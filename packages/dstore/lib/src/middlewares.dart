import 'package:dstore/src/action.dart';
import 'package:dstore/src/pstate.dart';
import 'package:dstore/src/store.dart';

dynamic asyncMiddleware<S extends AppStateI>(
    Store<S> store, Dispatch next, Action action) async {
  if (action.isProcessed || !action.isAsync) {
    next(action);
  } else {
    final sk = store.getStateKeyForReducerGroup(action.group);
    final psm = store.meta[sk]!;
    final gsMap = store.state.toMap();
    final currentS = gsMap[sk]!;
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.DATA,
            data: AsyncActionField(loading: true))));
    try {
      final s = await psm.aReducer(currentS, action);
      final asm = s.toMap();
      asm[action.name] = AsyncActionField();
      final newS = s.copyWithMap(asm);
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, data: newS, type: ActionInternalType.STATE)));
    } catch (e) {
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true,
              type: ActionInternalType.DATA,
              data: AsyncActionField(error: e))));
    }
  }
}

dynamic streamMiddleware<S extends AppStateI>(
    Store<S> store, Dispatch next, Action action) async {
  if (action.isProcessed || action.stream == null) {
    next(action);
  } else {
    final sub = action.stream?.listen((event) {
      final field = store.getFieldFromAction(action) as StreamField;
      store.dispatch(action.copyWith(
          internal: ActionInternal(
        processed: true,
        data: field.copyWith(loading: false, data: event, error: null),
        type: ActionInternalType.DATA,
      )));
    }, onError: (e) {
      final field = store.getFieldFromAction(action) as StreamField;
      store.dispatch(action.copyWith(
          internal: ActionInternal(
        processed: true,
        data: field.copyWith(loading: false, error: e),
        type: ActionInternalType.DATA,
      )));
    }, onDone: () {
      final field = store.getFieldFromAction(action) as StreamField;
      store.dispatch(action.copyWith(
          internal: ActionInternal(
        processed: true,
        data: field.copyWith(loading: false, error: null, completed: true),
        type: ActionInternalType.DATA,
      )));
    });
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.DATA,
            data: StreamField(internalSubscription: sub, loading: true))));
  }
}
