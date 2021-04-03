import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DRouterDelegate<S extends AppStateI<S>> extends RouterDelegate<dynamic>
    with ChangeNotifier {
  final Selector<S, NavStateI> selector;
  late final History history;
  late NavStateI _navState;
  late Dispatch _dispatch;
  bool _triggerFromHostory = false;
  DRouterDelegate({required this.selector}) {
    history = createHistory();
    history.listen(handleUriChange);
  }

  void handleUriChange(Uri uri) {
    print("Uri Changed2 ${uri.path}");
    final fn = _navState.dontTouchMeStaticMeta[uri.path.substring(1)];
    if (fn != null) {
      _triggerFromHostory = true;
      fn(uri, _dispatch);
    }
  }

  @override
  Widget build(BuildContext context) {
    _dispatch = context.dispatch;
    return SelectorBuilder<S, NavStateI>(
      selector: selector,
      onInitState: (context, state) {
        _navState = state;
      },
      shouldRebuild: (context, prevState, newState) {
        if (newState.redirectToAction != null) {
          final action = newState.redirectToAction!;
          newState.redirectToAction = null;
          scheduleMicrotask(() => _dispatch(action));
          return false;
        } else {
          _updateUrl(navState: newState);
          return true;
        }
      },
      builder: (context, state) {
        return Navigator(
          pages: state.buildPages(),
          onPopPage: (route, dynamic result) {
            print("on Pop Page");
            return false;
          },
        );
      },
    );
  }

  void _updateUrl({required NavStateI navState}) {
    if (_triggerFromHostory) {
      _triggerFromHostory = false;
    } else {
      if (navState.dontTouchMeUrl != null) {
        final url = navState.dontTouchMeUrl!;
        // print("pusing url ${navState.dontTouchMeUrl}");
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
    print("On Prop Route");
    return SynchronousFuture(true);
  }

  @override
  Future<void> setNewRoutePath(dynamic configuration) async {
    print("Set new Route Path");
    // do nothing
  }
}
