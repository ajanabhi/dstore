import 'package:dstore/dstore.dart';
import 'package:dstore/src/action.dart';
import 'package:dstore/src/store.dart';
import 'package:dstore/src/utils.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part "form.dstore.dart";

typedef FormFieldValidator = String? Function(dynamic value);

abstract class FormFieldObject<M> {
  M copyWithMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}

@DImmutable()
abstract class FormField<Key, F extends FormFieldObject<F>>
    with _$FormField<Key, F> {
  const factory FormField(
      {required F value,
      required Map<String, FormFieldValidator> validators,
      @Default(<dynamic, String>{}) Map<Key, String> errors,
      @Default(<dynamic, bool>{}) Map<Key, bool> touched,
      @Default(false) bool isValid,
      @Default(false) bool isSubmitting,
      @Default(false) bool isValidating,
      @Default(false) bool validateOnChange,
      @Default(false) bool validateOnBlur,
      @Default("") String internalAName,
      @Default("") String internalAType}) = _FormField<Key, F>;
}

class FromFieldPropInfo {
  final dynamic name;
  final dynamic value;
  final FormFieldValidator? validator;
  final String? error;
  final bool touched;
  final void Function(dynamic value) setValue;
  final void Function(String? value) setError;
  final void Function(bool value) setTouched;

  FromFieldPropInfo(
      {required this.name,
      required this.value,
      required this.validator,
      required this.error,
      required this.setError,
      required this.setValue,
      required this.setTouched,
      required this.touched});
}

abstract class FormReq {}

class FormSetFieldValue extends FormReq {
  final dynamic key;
  final dynamic value;
  final bool validate;

  FormSetFieldValue(
      {required this.key, required this.value, this.validate = false});
}

class FormSetFieldTouched extends FormReq {
  final dynamic key;
  final bool validate;

  FormSetFieldTouched({required this.key, this.validate = false});
}

class FormSetFieldError extends FormReq {
  final dynamic key;
  final String? value;

  FormSetFieldError({required this.key, this.value});
}

class FormSetErrors extends FormReq {
  final Map<dynamic, String> errors;

  FormSetErrors(this.errors);
}

class FormSetSubmitting extends FormReq {
  final bool isSubmitting;

  FormSetSubmitting(this.isSubmitting);
}

class FormReset extends FormReq {}

class FormValidate extends FormReq {}

class FormOps {
  final void Function(FormSetFieldValue req) setFieldValue;
  final void Function(FormSetFieldTouched req) setFieldTouched;
  final void Function(FormSetFieldError req) setFieldError;
  final void Function(FormSetErrors req) setErrors;
  final void Function(FormSetSubmitting req) setSubmitting;
  final void Function(FormReset req) resetForm;
  final void Function(FormValidate req) validateForm;

  FormOps(
      {required this.setFieldValue,
      required this.setFieldTouched,
      required this.setFieldError,
      required this.setErrors,
      required this.setSubmitting,
      required this.resetForm,
      required this.validateForm});
}

abstract class FormUtils {
  static FormOps getFormOps(FormField ff, Dispatch dispatch) {
    return FormOps(
      setFieldValue: (FormSetFieldValue req) {
        final a = Action<dynamic>(
            name: ff.internalAName, type: ff.internalAType, form: req);
        dispatch(a);
      },
      setFieldTouched: (FormSetFieldTouched req) {
        final a = Action<dynamic>(
            name: ff.internalAName, type: ff.internalAType, form: req);
        dispatch(a);
      },
      setFieldError: (FormSetFieldError req) {
        final a = Action<dynamic>(
            name: ff.internalAName, type: ff.internalAType, form: req);
        dispatch(a);
      },
      setErrors: (FormSetErrors req) {
        final a = Action<dynamic>(
            name: ff.internalAName, type: ff.internalAType, form: req);
        dispatch(a);
      },
      setSubmitting: (FormSetSubmitting req) {
        final a = Action<dynamic>(
            name: ff.internalAName, type: ff.internalAType, form: req);
        dispatch(a);
      },
      resetForm: (FormReset req) {
        final a = Action<dynamic>(
            name: ff.internalAName, type: ff.internalAType, form: req);
        dispatch(a);
      },
      validateForm: (FormValidate req) {
        final a = Action<dynamic>(
            name: ff.internalAName, type: ff.internalAType, form: req);
        dispatch(a);
      },
    );
  }

  static Future<Map<String, String>> isFormValid(FormField ff) async {
    final errors = <String, String>{};
    try {
      final values = ff.value.toMap();

      for (final e in ff.validators.entries) {
        final r = await e.value(values[e.key]);
        if (r != null) {
          errors[e.key] = r;
        }
      }
    } catch (e) {
      errors["VALIDATION_EXCEPTION"] = "$e";
    }
    return errors;
  }
}
