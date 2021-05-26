import 'package:dstore/src/action.dart';
import 'package:dstore/src/pstate.dart';
import 'package:dstore/src/store.dart';
import 'package:dstore/src/types.dart';
import 'package:dstore/src/utils/utils.dart';

dynamic _handlePsHistoryAction<S extends AppStateI<S>>(
    Store<S> store, Dispatch next, Action<dynamic> action) {
  final payload = action.psHistoryPayload!;
  final currentState =
      store.getPStateModelFromAction(action) as PStateHistoryMixin;
  print("_handlePsHistoryAction $currentState");
  if (action.name == "undo") {
    if (currentState.canUndo) {
      final initialState = store.getDefaultStateForAcion(action);
      final state =
          currentState.dontTouchMePSHistory.internalUndo(initialState)!;
      (state as PStateHistoryMixin).dontTouchMePSHistory =
          currentState.dontTouchMePSHistory;
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, type: ActionInternalType.PSTATE, data: state)));
      return;
    } else {
      print("nothing to undo");
      return;
    }
  }

  if (action.name == "redo") {
    print("executing ");
    if (currentState.canRedo) {
      final state = currentState.dontTouchMePSHistory
          .internalRedo(currentState as PStateModel);
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, type: ActionInternalType.PSTATE, data: state)));
      return;
    } else {
      print("nothing to redo");
      return;
    }
  }
  if (action.name == "clearHistory") {
    if (currentState.canRedo || currentState.canUndo) {
      currentState.dontTouchMePSHistory.internalClear();
      print("cleared history");
      return;
    } else {
      print("nothing to clear");
      return;
    }
  }
  next(action.copyWith(afterComplete: (newState) {
    final hState = newState as PStateHistoryMixin;
    final keys = payload.keysModified;
    final map = newState.toMap();
    map.removeWhere((key, dynamic value) => !keys.contains(key));
    hState.dontTouchMePSHistory.internalAdd(map);
  }));
}

dynamic psHistoryMiddleware<S extends AppStateI<S>>(
    Store<S> store, Dispatch next, Action<dynamic> action) {
  print("psHistoryMiddleware $action next $next store $store ");
  if (action.isProcessed) {
    return next(action);
  }
  dynamic mock = store.internalMocksMap[action.id]?.mock;
  if (mock != null) {
    // final mock
    mock = mock as ToMap;
    final model = store.getPStateModelFromAction(action);
    dynamic newS = model.copyWithMap(mock.toMap());
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true, data: newS, type: ActionInternalType.PSTATE)));
    return;
  }
  if (action.psHistoryPayload == null) {
    return next(action);
  }
  DstoreDevUtils.handleUnCaughtError(
      store: store,
      action: action,
      callback: () => _handlePsHistoryAction(store, next, action));
}
