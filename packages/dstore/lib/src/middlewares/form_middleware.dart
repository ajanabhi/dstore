import 'package:dstore/src/action.dart';
import 'package:dstore/src/form.dart';
import 'package:dstore/src/store.dart';

dynamic formMiddleware<S extends AppStateI<S>>(
    Store<S> store, Dispatch next, Action<dynamic> action) async {
  print("In from middleare");
  if (action.isProcessed || action.form == null) {
    next(action);
  } else {
    print("Processing form");
    // form action
    final req = action.form as FormReq;
    final ff = store.getFieldFromAction(action) as FormField;
    final pm = store.getPStateMetaFromAction(action);
    late FormField<dynamic, FormFieldObject<dynamic>> nff;
    if (req is FormSetFieldValue) {
      var validate = ff.validateOnChange;
      if (req.validate != null) {
        validate = req.validate!;
      }
      final validator = ff.validators[req.key];
      final errors = {...ff.errors};
      final touched = <String, bool>{...ff.touched, req.key: true};
      final name = FormUtils.getNameFromKey(req.key);
      final value = ff.value.copyWithMap(<String, dynamic>{name: req.value})
          as FormFieldObject;
      if (validate && validator != null) {
        final newE = (await validator(req.value)) as String?;
        if (newE != null) {
          errors[req.key] = newE;
        } else {
          errors.remove(req.key);
        }
      }
      nff = ff.copyWith(
          value: value,
          errors: errors,
          touched: touched,
          internalKeysChanged: [req.key],
          isValid: errors.isEmpty && _isFormValid(ff, touched));
    } else if (req is FormSetFieldTouched) {
      var validate = ff.validateOnBlur;
      if (req.validate) {
        validate = validate;
      }
      final errors = {...ff.errors};
      final validator = ff.validators[req.key];
      final touched = <String, bool>{...ff.touched, req.key: true};
      if (validate && validator != null) {
        final newE = (await validator(
            ff.value.toMap()[FormUtils.getNameFromKey(req.key)])) as String?;
        if (newE != null) {
          errors[req.key] = newE;
        } else {
          errors.remove(req.key);
        }
      }
      nff = ff.copyWith(
          touched: touched,
          errors: errors,
          internalKeysChanged: [req.key],
          isValid: errors.isEmpty && _isFormValid(ff, touched));
    } else if (req is FormSetFieldError) {
      final errors = {...ff.errors};
      if (req.value == null) {
        errors.remove(req.key);
      } else {
        errors[req.key] = req.value!;
      }
      nff = ff.copyWith(
          errors: errors,
          internalKeysChanged: [req.key],
          isValid: errors.isEmpty && _isFormValid(ff));
    } else if (req is FormSetErrors) {
      nff = ff.copyWith(errors: req.errors, isValid: req.errors.isEmpty);
    } else if (req is FormReset) {
      final df = pm.ds().toMap()[action.name] as FormField;
      nff = df.copyWith(internalKeysChanged: <String>[]);
    } else if (req is FormSetSubmitting) {
      nff = ff.copyWith(
          isSubmitting: req.isSubmitting, internalKeysChanged: null);
    } else if (req is FormValidate) {
      final errors = await FormUtils.isFormValid(ff);
      nff = ff.copyWith(
          errors: errors,
          isValid: errors.isEmpty,
          internalKeysChanged: errors.keys.toList());
    }
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true, type: ActionInternalType.DATA, data: nff)));
  }
}

bool _isFormValid(FormField ff,
    [Map<String, bool> touched = const <String, bool>{}]) {
  touched = touched.isEmpty ? ff.touched : touched;
  final vkeys = ff.validators.keys.toSet();
  final tKeys = touched.keys.toSet();
  return tKeys.containsAll(vkeys);
}
