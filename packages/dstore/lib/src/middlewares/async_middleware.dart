import 'package:dstore/src/action.dart';
import 'package:dstore/src/errors.dart';
import 'package:dstore/src/pstate.dart';
import 'package:dstore/src/store.dart';

dynamic asyncMiddleware<S extends AppStateI<S>>(
    Store<S> store, Dispatch next, Action<dynamic> action) async {
  print("Async middleware $action next $next store $store ");
  if (action.isProcessed || !action.isAsync) {
    next(action);
  } else {
    final sk = store.getStateKeyForPstateType(action.type);
    final psm = store.internalMeta[sk]!;
    final gsMap = store.state.toMap();
    final currentS = gsMap[sk]!;
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.FIELD,
            data: AsyncActionField(loading: true))));
    try {
      final s = await psm.aReducer!(currentS, action) as PStateModel;
      final asm = s.toMap();
      asm[action.name] = AsyncActionField(completed: true);
      final newS = s.copyWithMap(asm) as PStateModel;
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, data: newS, type: ActionInternalType.PSTATE)));
    } catch (e) {
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true,
              type: ActionInternalType.FIELD,
              data: AsyncActionField(error: e, completed: true))));
    }
  }
}
