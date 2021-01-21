import 'package:dstore/src/action.dart';
import 'package:dstore/src/store.dart';

typedef FormFieldValidator = dynamic Function(dynamic value);

abstract class FormFieldObject<M> {
  M copyWithMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}

class FormField<F extends FormFieldObject> {
  final F value;
  final Map<String, FormFieldValidator> validators;
  final Map<String, String> errors;
  final Map<String, bool> touched;
  final bool isValid;
  final bool isSubmitting;
  final bool isValidating;
  final bool validateOnChange;
  final bool validateOnBlur;
  final String internalAName;
  final int internalAGroup;
  FormField(
      {required this.value,
      required this.validators,
      this.touched = const {},
      this.isValid = false,
      this.isSubmitting = false,
      this.isValidating = false,
      this.validateOnChange = false,
      this.validateOnBlur = false,
      this.internalAName = "",
      this.internalAGroup = 0,
      this.errors = const {}});

  FormField<F> copyWith({
    F? value,
    Map<String, FormFieldValidator>? validators,
    Map<String, String>? errors,
    Map<String, bool>? touched,
    bool? isValid,
    bool? isSubmitting,
    bool? isValidating,
    bool? validateOnChange,
    bool? validateOnBlur,
    String? internalAName,
    int? internalAGroup,
  }) {
    return FormField<F>(
      value: value ?? this.value,
      validators: validators ?? this.validators,
      errors: errors ?? this.errors,
      touched: touched ?? this.touched,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isValidating: isValidating ?? this.isValidating,
      validateOnChange: validateOnChange ?? this.validateOnChange,
      validateOnBlur: validateOnBlur ?? this.validateOnBlur,
      internalAName: internalAName ?? this.internalAName,
      internalAGroup: internalAGroup ?? this.internalAGroup,
    );
  }
}

abstract class FormReq {}

class FormSetFieldValue extends FormReq {
  final String key;
  final dynamic value;
  final bool validate;

  FormSetFieldValue(
      {required this.key, required this.value, this.validate = false});
}

class FormSetFieldTouched extends FormReq {
  final String key;
  final bool validate;

  FormSetFieldTouched({required this.key, this.validate = false});
}

class FormSetFieldError extends FormReq {
  final String key;
  final String? value;

  FormSetFieldError({required this.key, this.value});
}

class FormSetErrors extends FormReq {
  final Map<String, String> errors;

  FormSetErrors(this.errors);
}

class FormSetSubmitting extends FormReq {
  final bool isSubmitting;

  FormSetSubmitting(this.isSubmitting);
}

class FormReset extends FormReq {}

class FormValidate extends FormReq {}

class FormOps {
  final void Function(FormSetFieldError req) setFieldValue;
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

abstract class MiddlewareFormUtils {
  static FormOps getFormOps(FormField ff, Dispatch dispatch) {
    return FormOps(
      setFieldValue: (FormSetFieldError req) {
        final a =
            Action(name: ff.internalAName, group: ff.internalAGroup, form: req);
        dispatch(a);
      },
      setFieldTouched: (FormSetFieldTouched req) {
        final a =
            Action(name: ff.internalAName, group: ff.internalAGroup, form: req);
        dispatch(a);
      },
      setFieldError: (FormSetFieldError req) {
        final a =
            Action(name: ff.internalAName, group: ff.internalAGroup, form: req);
        dispatch(a);
      },
      setErrors: (FormSetErrors req) {
        final a =
            Action(name: ff.internalAName, group: ff.internalAGroup, form: req);
        dispatch(a);
      },
      setSubmitting: (FormSetSubmitting req) {
        final a =
            Action(name: ff.internalAName, group: ff.internalAGroup, form: req);
        dispatch(a);
      },
      resetForm: (FormReset req) {
        final a =
            Action(name: ff.internalAName, group: ff.internalAGroup, form: req);
        dispatch(a);
      },
      validateForm: (FormValidate req) {
        final a =
            Action(name: ff.internalAName, group: ff.internalAGroup, form: req);
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
