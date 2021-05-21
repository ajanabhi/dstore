import "package:dstore/dstore.dart";
import 'package:dstore_flutter/dstore_flutter.dart';

void _handleNavAction<S extends AppStateI<S>>(
    Action action, Dispatch next, Store<S> store) {
  print("field ${store.getFieldFromAction(action)}");
  final navPayload = action.nav!;
  final navState = store.getPStateModelFromAction(action) as NavStateI;
  String? typeName;
  if (navState is NestedNavStateI) {
    typeName = navState.dontTouchMe.typeName;
  }
  final history = navState.dontTouchMe.hisotry;
  print(
      "nav middleware typeName $typeName navHistory  ${history.nestedNavsHistory}");
  if (navPayload.isUrlBased &&
      typeName != null &&
      !history.nestedNavsHistory.containsKey(typeName)) {
    // nested stack not initialized yet
    history.nestedNavOrigins[typeName] = action;
    final a = history.nestedNavMeta[typeName]!;
    print("modified a $a");
    store.dispatch(a);
  } else if (!navState.meta.blockSameUrl ||
      navState.meta.navOptions?.reload == true) {
    //
    next(action);
  } else {
    final uri = Uri.parse(history.url);
    if (uri.path == navState.dontTouchMe.url) {
      // do nothing
    } else {
      next(action);
    }
  }
}

dynamic navigaionMiddleware<S extends AppStateI<S>>(
    Store<S> store, Dispatch next, Action<dynamic> action) {
  if (action.isProcessed || action.nav == null) {
    next(action);
  } else {
    _handleNavAction(action, next, store);
  }
}
