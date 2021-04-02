import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DRouterDelegate<S extends AppStateI<S>> extends RouterDelegate<dynamic>
    with ChangeNotifier {
  final Selector<S, NavStateI> selector;
  final Store<S> store;
  late final History history;
  late NavStateI _navState;
  late Dispatch _dispatch;
  DRouterDelegate({required this.selector, required this.store}) {
    history = createHistory();
    history.listen(handleUriChange);
  }

  void handleUriChange(Uri uri) {
    print("Uri Changed ${uri.path}");
    final fn = _navState.dontTouchMeStaticMeta[uri.path.substring(1)];
    if (fn != null) {
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
      onStateChange: (context, prevState, newState) {
        // _navState = newState;
        print("State Change $newState");
        if (newState.dontTouchMeUrl != null) {
          history.push(newState.dontTouchMeUrl!);
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
