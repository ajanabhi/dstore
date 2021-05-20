import "package:dstore/dstore.dart";
import 'package:dstore_flutter/dstore_flutter.dart';

void _handleNavAction<S extends AppStateI<S>>(
    Action action, Dispatch next, Store<S> store) {
  print("field ${store.getFieldFromAction(action)}");

  final navState = store.getPStateModelFromAction(action) as NavStateI;
  String? typeName;
  if (navState is NestedNavStateI) {
    typeName = navState.dontTouchMeTypeName;
  }
  final history = navState.dontTouchMeHistory;
  print(
      "nav middleware typeName $typeName navHistory  ${history.nestedNavsHistory}");
  if (typeName != null && !history.nestedNavsHistory.containsKey(typeName)) {
    // nested stack not initialized yet
    final a = action.copyWith(
        silent: true,
        afterSilent: (PStateModel s) {
          s = s as NavStateI;
          store.dispatch(history.fallBackNestedStackNonInitializationAction(s));
        });
    print("modified a $a");
    // history.originAction = navState.originAction;
    next(a);
  } else if (!navState.blockSameUrl || navState.navOptions?.reload == true) {
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
