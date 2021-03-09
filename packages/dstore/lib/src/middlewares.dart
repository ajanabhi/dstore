import 'dart:async';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/form.dart';
import 'package:dstore/src/helper_classes.dart';
import 'package:dstore/src/pstate.dart';
import 'package:dstore/src/store.dart';

final Middleware asyncMiddleware =
    (Store store, Dispatch next, Action action) async {
  if (action.isProcessed || !action.isAsync) {
    next(action);
  } else {
    final sk = store.getStateKeyForReducerGroup(action.type);
    final psm = store.meta[sk]!;
    final gsMap = store.state.toMap();
    final currentS = gsMap[sk]!;
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.DATA,
            data: AsyncActionField(loading: true))));
    try {
      final s = await psm.aReducer!(currentS, action);
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
};

final Middleware debounceMiddleware =
    (Store store, Dispatch next, Action action) async {
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
};

final Middleware streamMiddleware =
    (Store store, Dispatch next, Action action) async {
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
      final sub = action.stream?.listen((event) {
        final field = store.getFieldFromAction(action) as StreamField;
        store.dispatch(action.copyWith(
            internal: ActionInternal(
          processed: true,
          data: field.copyWith(data: Optional(event), error: Optional(null)),
          type: ActionInternalType.DATA,
        )));
      }, onError: (e) {
        final field = store.getFieldFromAction(action) as StreamField;
        store.dispatch(action.copyWith(
            internal: ActionInternal(
          processed: true,
          data: field.copyWith(error: Optional(e)),
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
              data: StreamField(internalSubscription: sub, listening: true))));
    }
  }
};
dynamic formMiddleware<S extends AppStateI>(
    Store<S> store, Dispatch next, Action action) async {
  if (action.isProcessed || action.form == null) {
    next(action);
  } else {
    // form action
    final req = action.form!;
    final ff = store.getFieldFromAction(action) as FormField;
    final pm = store.getPStateMetaFromAction(action);
    late FormField nff;
    if (req is FormSetFieldValue) {
      var validate = ff.validateOnChange;
      if (req.validate) {
        validate = req.validate;
      }
      final validator = ff.validators[req.key];
      final errors = {...ff.errors};
      final value = ff.value.copyWithMap({req.key: req.value});
      if (validate && validator != null) {
        final newE = await validator(req.value);
        if (newE != null) {
          errors[req.key] = newE;
        }
      }
      nff = ff.copyWith(value: value, errors: errors, isValid: errors.isEmpty);
    } else if (req is FormSetFieldTouched) {
      var validate = ff.validateOnBlur;
      if (req.validate) {
        validate = validate;
      }
      final errors = {...ff.errors};
      final validator = ff.validators[req.key];
      final touched = {...ff.touched, req.key: true};
      if (validate && validator != null) {
        final newE = await validator(ff.value.toMap()[req.key]);
        if (newE != null) {
          errors[req.key] = newE;
        }
      }
      nff = ff.copyWith(
          touched: touched, errors: errors, isValid: errors.isEmpty);
    } else if (req is FormSetFieldError) {
      final errors = {...ff.errors};
      if (req.value == null) {
        errors.remove(req.key);
      } else {
        errors[req.key] = req.value!;
      }
      nff = ff.copyWith(errors: errors, isValid: errors.isEmpty);
    } else if (req is FormSetErrors) {
      nff = ff.copyWith(errors: req.errors, isValid: req.errors.isEmpty);
    } else if (req is FormReset) {
      nff = pm.ds().toMap()[action.name];
    } else if (req is FormSetSubmitting) {
      nff = ff.copyWith(isSubmitting: req.isSubmitting);
    } else if (req is FormValidate) {
      final errors = await MiddlewareFormUtils.isFormValid(ff);
      nff = ff.copyWith(errors: errors, isValid: errors.isEmpty);
    }
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true, type: ActionInternalType.DATA, data: nff)));
  }
}
