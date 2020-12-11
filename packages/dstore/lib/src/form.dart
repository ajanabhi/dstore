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
  FormField(
      {required this.value,
      required this.validators,
      this.touched = const {},
      this.isValid = false,
      this.isSubmitting = false,
      this.isValidating = false,
      this.validateOnChange = false,
      this.validateOnBlur = false,
      this.errors = const {}});
}

abstract class FormReq {}

class SetFieldValueReq extends FormReq {
  final String key;
  final dynamic value;
  final bool validate;

  SetFieldValueReq(
      {required this.key, required this.value, this.validate = false});
}
