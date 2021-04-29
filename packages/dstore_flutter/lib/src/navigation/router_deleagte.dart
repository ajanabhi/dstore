import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:dstore_flutter/src/navigation/navigation_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DRouterDelegate<S extends AppStateI<S>> extends RouterDelegate<String>
    with ChangeNotifier {
  final Selector<S, NavStateI> selector;
  late final History history;
  late NavStateI _navState;
  late Dispatch _dispatch;
  bool _triggerFromHistory = false;
  late String _initialUrl;
  DRouterDelegate({required this.selector}) {
    history = createHistory();
    history.listen(handleUriChange);
  }

  void handleUriChange(Uri uri) {
    print("Uri Changed3 ${uri.path}");
    UrlToAction? fn;
    final path = uri.path;
    fn = _navState.dontTouchMeStaticMeta[path];
    print("Url to Action2 $fn");
    if (fn != null) {
      _triggerFromHistory = true;
      fn(uri, _dispatch);
    } else {
      // match in dynamic paths

    }
  }

  @override
  Widget build(BuildContext context) {
    _dispatch = context.dispatch;
    print("Builder router");
    return NavigationProvider(
        history: history,
        child: SelectorBuilder<S, NavStateI>(
          selector: selector,
          onInitState: (context, state) {
            _navState = state;
            handleUriChange(Uri.parse(_initialUrl));
          },
          shouldRebuild: (context, prevState, newState) {
            if (newState.redirectToAction != null) {
              final action = newState.redirectToAction!;
              newState.redirectToAction = null;
              scheduleMicrotask(() => _dispatch(action));
              return false;
            } else {
              if (_triggerFromHistory == true) {
                _triggerFromHistory = false;
              } else {
                _updateUrl(navState: newState);
              }
              return true;
            }
          },
          builder: (context, state) {
            print("Page : ${state.page}");
            final pages =
                state.page != null ? [state.page!] : state.buildPages();
            return pages.isEmpty
                ? Container()
                : Navigator(
                    pages: pages,
                    onPopPage: (route, dynamic result) {
                      print("on Pop Page");
                      return false;
                    },
                  );
          },
        ));
  }

  void _updateUrl({required NavStateI navState}) {
    if (history.urlChangedInSystem) {
      print("Url Changed in system");
      history.urlChangedInSystem = false;
    } else {
      if (navState.dontTouchMeUrl != null) {
        final url = navState.dontTouchMeUrl!;
        print("pushing url ${navState.dontTouchMeUrl}");
        if (navState.historyUpdate == HistoryUpdate.replace) {
          history.replace(url);
        } else {
          history.push(url);
        }
        navState.historyUpdate = null;
      }
    }
  }

  @override
  Future<bool> popRoute() {
    final url = history.goBack();
    print("Pop route2 url : $url");
    if (url.isEmpty) {
      return SynchronousFuture(false);
    }
    scheduleMicrotask(() {
      handleUriChange(Uri.parse(url));
    });
    return SynchronousFuture(true);
  }

  @override
  Future<void> setInitialRoutePath(String url) async {
    print("setInitialRoutePath config $url");
    history.setInitialUrl(url);
    _initialUrl = url;
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    print("Set new Route Path config $configuration");
    // do nothing
  }
}
