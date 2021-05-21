import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:dstore_flutter/src/navigation/navigation_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:collection/collection.dart';

class DRouterDelegate<S extends AppStateI<S>> extends RouterDelegate<String>
    with ChangeNotifier {
  final Selector<S, NavStateI> selector;
  final Widget Function(Widget child) shell;
  final GlobalKey<NavigatorState> navigatorKey;
  late final History history;
  NavStateI? _navState;
  NavStateI get navState => _navState!;
  VoidCallback? unsubscribeHistoryListener;
  late Dispatch _dispatch;
  bool _preparedState = false;
  DRouterDelegate({required this.selector, this.shell = IdentityFn})
      : navigatorKey = GlobalKey<NavigatorState>() {
    history = createHistory();
    unsubscribeHistoryListener = history.listen(handleUriChange);
  }

  void handleUriChange(Uri uri) {
    print("Uri Changed3 ${uri.path}");
    UrlToAction? fn;
    final path = uri.path;

    fn = _navState!.dontTouchMeStaticMeta[path];
    print("Url to Action2 $fn");
    if (fn != null) {
      history.urlChangedInSystem = true;
      fn(uri, _dispatch);
    } else {
      // match in dynamic paths
      final r = 'r"$path"';
      final regExp = pathToRegExp(r);
      final dfn = navState.dontTouchMeDynamicMeta.entries
          .singleWhereOrNull((de) => regExp.hasMatch(de.key))
          ?.value;
      if (dfn == null) {
        _dispatch(navState.notFoundAction(uri));
      } else {
        history.urlChangedInSystem = true;
        dfn(uri, _dispatch);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _dispatch = context.dispatch;
    return NavigationProvider(
        dotTouchmeHistory: history,
        child: shell(SelectorBuilder<S, NavStateI>(
          selector: selector,
          onInitState: (context, state) {
            state.dontTouchMeHistory = history;
            final nestedNavs = state.getNestedNavs();
            if (nestedNavs.isNotEmpty) {
              nestedNavs.forEach((nnav) {
                nnav.dontTouchMeHistory = history;
                state.dontTouchMeStaticMeta.addAll(nnav.dontTouchMeStaticMeta);
                state.dontTouchMeDynamicMeta
                    .addAll(nnav.dontTouchMeDynamicMeta);
              });
            }
            _navState = state;
            history.blockSameUrl = state.blockSameUrl;
            history.fallBackNestedStackNonInitializationAction =
                state.fallBackNestedStackNonInitializationAction;
          },
          onInitialBuild: (context, state) {
            _preparedState = true;
            handleUriChange(Uri.parse(history.url));
          },
          shouldRebuild: (context, prevState, newState) {
            newState.dontTouchMeHistory = history;
            if (newState.meta.redirectToAction != null) {
              print("NavParent inredirect");
              final meta = newState.meta;
              final action = meta.redirectToAction!;
              meta.redirectToAction = null;
              history.originAction = meta.originAction;
              meta.originAction = null;
              scheduleMicrotask(() => _dispatch(action));
              return false;
            } else if (history.originAction != null) {
              print("NavParent in Origin");
              final a = history.originAction!;
              history.originAction = null;
              context.dispatch(a);
              return false;
            } else {
              print("NavParent in update");
              if (history.urlChangedInSystem == true) {
                history.urlChangedInSystem = false;
              } else {
                _updateUrl(navState: newState);
                print("Page ${newState.page} ${(newState.page)}");
              }
              return true;
            }
          },
          builder: (context, state) {
            return _preparedState
                ? Navigator(
                    key: navigatorKey,
                    transitionDelegate: NoAnimationTransitionDelegate(),
                    pages:
                        state.page != null ? [state.page!] : state.buildPages(),
                    onPopPage: (route, dynamic result) {
                      history.goBack();

                      return true;
                    },
                  )
                : SizedBox.shrink();
          },
        )));
  }

  void _updateUrl({required NavStateI navState}) {
    if (navState.dontTouchMeUrl != null) {
      final url = navState.dontTouchMeUrl!;
      print("pushing url ${navState.dontTouchMeUrl}");
      if (navState.meta.navOptions?.historyUpdate == HistoryUpdate.replace) {
        history.replace(url);
      } else {
        history.push(url);
      }
      navState.meta.navOptions = null;
    }
  }

  @override
  Future<bool> popRoute() {
    if (history.canGoBack) {
      history.goBack();
      return SynchronousFuture(true);
    } else {
      return SynchronousFuture(false);
    }
  }

  @override
  Future<void> setInitialRoutePath(String url) async {
    print("setInitialRoutePath config $url");
    history.setInitialUrl(url);
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    print("Set new Route Path config $configuration");
    // do nothing
  }

  @override
  void dispose() {
    unsubscribeHistoryListener?.call();
    super.dispose();
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord>
        locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>>
        pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];

    for (final RouteTransitionRecord pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }
    for (final RouteTransitionRecord exitingPageRoute
        in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final List<RouteTransitionRecord>? pagelessRoutes =
            pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final RouteTransitionRecord pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);
    }
    return results;
  }
}
