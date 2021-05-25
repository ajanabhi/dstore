import "package:dstore/dstore.dart";
import 'package:dstore_flutter/dstore_flutter.dart';

void _handleNavAction<S extends AppStateI<S>>(
    Action action, Dispatch next, Store<S> store) async {
  print("field ${store.getFieldFromAction(action)}");
  final navPayload = action.nav!;
  print("navPayload $navPayload");
  final navState = store.getPStateModelFromAction(action) as NavStateI;
  String? typeName;
  if (navState is NestedNavStateI) {
    typeName = navState.dontTouchMe.typeName;
  }
  final history = navState.dontTouchMe.hisotry;
  print(
      "nav middleware typeName $typeName navHistory  ${history.nestedNavsHistory} before leave ${history.beforeLeave}");
  final allowToLeave =
      handleBeforeLeave(history: history, store: store, action: action);
  if (!allowToLeave) {
    print(
        "Skiping nav action $action , because its prevent by beforeLeave function");
    return;
  }

  if (navPayload.rawUrl != null &&
      typeName != null &&
      !history.nestedNavsHistory.containsKey(typeName)) {
    // nested stack not initialized yet
    print("Parent stack not initialized for type $typeName ");
    history.nestedNavOrigins[typeName] = action;
    final a = history.nestedNavMeta[typeName]!;
    print("modified a $a");
    store.dispatch(a);
    return;
  }
  if (!navState.meta.blockSameUrl || navState.meta.navOptions?.reload == true) {
    //
    next(action);
    return;
  }
  final uri = Uri.parse(history.url);
  if (uri.path == navState.dontTouchMe.url) {
    // do nothing
  } else {
    next(action);
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
