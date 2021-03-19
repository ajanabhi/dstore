import 'dart:async';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/form.dart';
import 'package:dstore/src/types.dart';
import 'package:dstore/src/pstate.dart';
import 'package:dstore/src/store.dart';

dynamic asyncMiddleware<S extends AppStateI<S>>(
    Store<S, dynamic> store, Dispatch next, Action action) async {
  if (action.isProcessed || !action.isAsync) {
    next(action);
  } else {
    final sk = store.getStateKeyForPstateType(action.type);
    final psm = store.meta[sk]!;
    final gsMap = store.state.toMap();
    final currentS = gsMap[sk]!;
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.DATA,
            data: AsyncActionField(loading: true))));
    try {
      final s = await psm.aReducer!(currentS, action) as PStateModel;
      final asm = s.toMap();
      asm[action.name] = AsyncActionField(completed: true);
      final newS = s.copyWithMap(asm) as PStateModel;
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, data: newS, type: ActionInternalType.STATE)));
    } catch (e) {
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true,
              type: ActionInternalType.DATA,
              data: AsyncActionField(error: e, completed: true))));
    }
  }
}

dynamic debounceMiddleware<S extends AppStateI<S>>(
    Store store, Dispatch next, Action action) async {
  if (action.isProcessed || action.debounce == null) {
    next(action);
  } else {
    final duration = action.debounce!;
    final id = "${action.type.hashCode}.${action.name}";
    if (duration == Duration.zero) {
      // if duration is zero then execute immediatley
      store.internalDebounceTimers[id]?.cancel();
      store.internalDebounceTimers.remove(id);
      next(action);
    } else {
      store.internalDebounceTimers[id]?.cancel();
      store.internalDebounceTimers[id] = Timer(duration, () {
        store.internalDebounceTimers[id]?.cancel();
        store.internalDebounceTimers.remove(id);
        next(action);
      });
    }
  }
}

dynamic streamMiddleware<S extends AppStateI<S>>(
    Store store, Dispatch next, Action action) async {
  if (action.isProcessed || action.stream == null) {
    next(action);
  } else {
    final field = store.getFieldFromAction(action) as StreamField;
    if (field.listening) {
      //  already listening
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, type: ActionInternalType.DATA, data: field)));
    } else {
      final sub = action.stream?.listen((dynamic event) {
        final field = store.getFieldFromAction(action) as StreamField;
        store.dispatch(action.copyWith(
            internal: ActionInternal(
          processed: true,
          data: field.copyWith(
              data: Optional<dynamic>(event), error: Optional(null)),
          type: ActionInternalType.DATA,
        )));
      }, onError: (dynamic e) {
        final field = store.getFieldFromAction(action) as StreamField;
        store.dispatch(action.copyWith(
            internal: ActionInternal(
          processed: true,
          data: field.copyWith(error: Optional<dynamic>(e)),
          type: ActionInternalType.DATA,
        )));
      }, onDone: () {
        final field = store.getFieldFromAction(action) as StreamField;
        store.dispatch(action.copyWith(
            internal: ActionInternal(
          processed: true,
          data: field.copyWith(
              listening: false, error: Optional(null), completed: true),
          type: ActionInternalType.DATA,
        )));
      });
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true,
              type: ActionInternalType.DATA,
              data: StreamField<dynamic>(
                  internalSubscription: sub, listening: true))));
    }
  }
}
