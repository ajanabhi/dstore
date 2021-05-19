import "package:dstore/dstore.dart";
import 'package:dstore_flutter/dstore_flutter.dart';

void _handleNavAction<S extends AppStateI<S>>(
    Action action, Dispatch next, Store<S> store) {
  print("field ${store.getFieldFromAction(action)}");
  final navState = store.getPStateModelFromAction(action) as NavStateI;
  final history = navState.dontTouchMeHistory;
  if (!navState.blockSameUrl || navState.navOptions?.reload == true) {
    //
    next(action);
  } else {
    final uri = Uri.parse(history.url);
    if (uri.path == navState.dontTouchMeUrl) {
      // do nothing
    } else {
      next(action);
    }
  }
}

dynamic navigaionMiddleware<S extends AppStateI<S>>(
    Store<S> store, Dispatch next, Action<dynamic> action) {
  if (action.isProcessed || !action.isNav) {
    next(action);
  } else {
    _handleNavAction(action, next, store);
  }
}
