import 'package:dstore/dstore.dart';

dynamic formMiddleware<S extends AppStateI<S>>(
    Store<S, dynamic> store, Dispatch next, Action<dynamic> action) async {
  if (action.isProcessed || action.form == null) {
    next(action);
  } else {
    // form action
    final req = action.form as FormReq;
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
      final value = ff.value.copyWithMap(<String, dynamic>{req.key: req.value})
          as FormFieldObject;
      if (validate && validator != null) {
        final newE = await validator(req.value) as String?;
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
        final newE = await validator(ff.value.toMap()[req.key]) as String?;
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
      nff = pm.ds().toMap()[action.name] as FormField;
    } else if (req is FormSetSubmitting) {
      nff = ff.copyWith(isSubmitting: req.isSubmitting);
    } else if (req is FormValidate) {
      final errors = await FormUtils.isFormValid(ff);
      nff = ff.copyWith(errors: errors, isValid: errors.isEmpty);
    }
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true, type: ActionInternalType.DATA, data: nff)));
  }
}
