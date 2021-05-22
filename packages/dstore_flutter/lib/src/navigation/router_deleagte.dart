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

    fn = _navState!.dontTouchMe.staticMeta[path];
    print("Url to Action2 $fn");
    if (fn != null) {
      history.urlChangedInSystem = true;
      fn(uri, _dispatch);
    } else {
      // match in dynamic paths
      final r = 'r"$path"';
      final regExp = pathToRegExp(r);
      final dfn = navState.dontTouchMe.dynamicMeta.entries
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
            state.dontTouchMe.hisotry = history;
            final nestedNavs = state.getNestedNavs();
            prepareStateFromNestedStacks(
                history: history, state: state, nestedNavsMeta: nestedNavs);
            _navState = state;
            history.blockSameUrl = state.meta.blockSameUrl;
            history.fallBackNestedStackNonInitializationAction =
                state.fallBackNestedStackNonInitializationAction;
            history.historyMode = state.dontTouchMe.historyMode;
          },
          onInitialBuild: (context, state) {
            _preparedState = true;
            handleUriChange(Uri.parse(history.url));
          },
          shouldRebuild: (context, prevState, newState) {
            newState.dontTouchMe.hisotry = history;
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
                      if (route.didPop(result)) {
                        print("On Pop nested");
                        history.goBack();
                        return true;
                      } else {
                        print("Nested pop fail");
                        return false;
                      }
                    },
                  )
                : SizedBox.shrink();
          },
        )));
  }

  void prepareStateFromNestedStacks(
      {required History history,
      required NavStateI state,
      required List<NestedNavStateMeta> nestedNavsMeta}) {
    nestedNavsMeta.forEach((nnavmeta) {
      final nnav = nnavmeta.state;
      final rmeta = nnav.getNestedNavs();
      if (rmeta.isNotEmpty) {
        prepareStateFromNestedStacks(
            history: history, state: state, nestedNavsMeta: rmeta);
      }
      nnav.dontTouchMe.hisotry = history;
      state.dontTouchMe.staticMeta.addAll(nnav.dontTouchMe.staticMeta);
      state.dontTouchMe.dynamicMeta.addAll(nnav.dontTouchMe.dynamicMeta);
      history.nestedNavMeta[nnav.dontTouchMe.typeName] = nnavmeta.rootAction;
    });
  }

  void _updateUrl({required NavStateI navState}) {
    final url = navState.dontTouchMe.url;
    if (url != null) {
      print("pushing url ${url}");
      if (navState.meta.navOptions?.historyUpdate == HistoryUpdate.replace) {
        history.replace(url);
      } else {
        history.push(url);
      }
      navState.meta.navOptions = null;
    }
  }

  @override
  Future<bool> popRoute() async {
    print("popRoute");
    final currentActiveNestedNav = history.currentActiveNestedNav;
    print("currentActiveNestedNav $currentActiveNestedNav");
    if (currentActiveNestedNav != null) {
      print("hmm ${history.nestedNavsHistory[currentActiveNestedNav]}");
      final nestedHistory = history.nestedNavsHistory[currentActiveNestedNav]!;
      print("nested");
      print("Nested history Mode : ${nestedHistory.historyMode}");
      if (nestedHistory.historyMode == HistoryMode.tabs) {
        if (nestedHistory.canGoBack) {
          nestedHistory.goBack();
          return true;
        }
      } else {
        print("curentNavkey ${history.currentNavKey}");
        final currentNestedNavKey = history.currentNavKey!;
        print("currentNavKey $currentNestedNavKey");
        final r = await currentNestedNavKey.currentState!.maybePop();
        print("result $r");
        if (r) {
          return true;
        }
      }
    }
    print("forwarding to global ${history.historyMode}");
    if (history.historyMode == HistoryMode.tabs) {
      if (history.canGoBack) {
        history.goBack();
        return true;
      } else {
        return false;
      }
    } else {
      return navigatorKey.currentState!.maybePop();
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

//TODO  shell is rebuilding after back recheck
