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
  final String internalAGroup;
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
      this.internalAGroup = "",
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
    String? internalAGroup,
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

class SetFieldValueReq extends FormReq {
  final String key;
  final dynamic value;
  final bool validate;

  SetFieldValueReq(
      {required this.key, required this.value, this.validate = false});
}

class SetFieldTouchedReq extends FormReq {
  final String key;
  final bool validate;

  SetFieldTouchedReq({required this.key, this.validate = false});
}

class SetFieldErrorReq extends FormReq {
  final String key;
  final String? value;

  SetFieldErrorReq({required this.key, this.value});
}

class SetErrorsReq extends FormReq {
  final Map<String, String> errors;

  SetErrorsReq(this.errors);
}

class FormSubmittingReq extends FormReq {
  final bool isSubmitting;

  FormSubmittingReq(this.isSubmitting);
}

class FormResetReq extends FormReq {}

class FormValidateReq extends FormReq {}

class FormOps {
  final void Function(SetFieldErrorReq req) setFieldValue;
  final void Function(SetFieldTouchedReq req) setFieldTouched;
  final void Function(SetFieldErrorReq req) setFieldError;
  final void Function(SetErrorsReq req) setErrors;
  final void Function(FormSubmittingReq req) setSubmitting;
  final void Function(FormResetReq req) resetForm;
  final void Function(FormValidateReq req) validateForm;

  FormOps(
      {required this.setFieldValue,
      required this.setFieldTouched,
      required this.setFieldError,
      required this.setErrors,
      required this.setSubmitting,
      required this.resetForm,
      required this.validateForm});
}
