// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'form.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$FormField<Key, F extends FormFieldObject<F>> {
  F get value;
  Map<String, Function> get validators;
  Map<String, String> get errors;
  Map<String, bool> get touched;
  bool get isValid;
  bool get isSubmitting;
  bool get isValidating;
  bool get validateOnChange;
  bool get validateOnBlur;
  List<String>? get internalKeysChanged;
  String get internalAName;
  String get internalAType;

  $FormFieldCopyWith<Key, F, FormField<Key, F>> get copyWith;
}

class _FormField<Key, F extends FormFieldObject<F>>
    implements FormField<Key, F> {
  @override
  final F value;

  @override
  final Map<String, Function> validators;

  @override
  @Default(<String, String>{})
  @JsonKey(defaultValue: const <String, String>{})
  final Map<String, String> errors;

  @override
  @Default(<String, bool>{})
  @JsonKey(defaultValue: const <String, bool>{})
  final Map<String, bool> touched;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool isValid;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool isSubmitting;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool isValidating;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool validateOnChange;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool validateOnBlur;

  @override
  final List<String>? internalKeysChanged;

  @override
  @Default("")
  @JsonKey(defaultValue: "")
  final String internalAName;

  @override
  @Default("")
  @JsonKey(defaultValue: "")
  final String internalAType;

  _$FormFieldCopyWith<Key, F, FormField<Key, F>> get copyWith =>
      __$FormFieldCopyWithImpl<Key, F, FormField<Key, F>>(this, IdentityFn);

  const _FormField(
      {required this.value,
      required this.validators,
      this.errors = const <String, String>{},
      this.touched = const <String, bool>{},
      this.isValid = false,
      this.isSubmitting = false,
      this.isValidating = false,
      this.validateOnChange = false,
      this.validateOnBlur = false,
      this.internalKeysChanged,
      this.internalAName = "",
      this.internalAType = ""});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _FormField &&
        o.value == value &&
        o.validators == validators &&
        o.errors == errors &&
        o.touched == touched &&
        o.isValid == isValid &&
        o.isSubmitting == isSubmitting &&
        o.isValidating == isValidating &&
        o.validateOnChange == validateOnChange &&
        o.validateOnBlur == validateOnBlur &&
        o.internalKeysChanged == internalKeysChanged &&
        o.internalAName == internalAName &&
        o.internalAType == internalAType;
  }

  @override
  int get hashCode =>
      value.hashCode ^
      validators.hashCode ^
      errors.hashCode ^
      touched.hashCode ^
      isValid.hashCode ^
      isSubmitting.hashCode ^
      isValidating.hashCode ^
      validateOnChange.hashCode ^
      validateOnBlur.hashCode ^
      internalKeysChanged.hashCode ^
      internalAName.hashCode ^
      internalAType.hashCode;

  @override
  String toString() =>
      "FormField(value: ${this.value}, validators: ${this.validators}, errors: ${this.errors}, touched: ${this.touched}, isValid: ${this.isValid}, isSubmitting: ${this.isSubmitting}, isValidating: ${this.isValidating}, validateOnChange: ${this.validateOnChange}, validateOnBlur: ${this.validateOnBlur}, internalKeysChanged: ${this.internalKeysChanged}, internalAName: ${this.internalAName}, internalAType: ${this.internalAType})";
}

abstract class $FormFieldCopyWith<Key, F extends FormFieldObject<F>, O> {
  factory $FormFieldCopyWith(
          FormField<Key, F> value, O Function(FormField<Key, F>) then) =
      _$FormFieldCopyWithImpl<Key, F, O>;
  O call(
      {F value,
      Map<String, Function> validators,
      Map<String, String> errors,
      Map<String, bool> touched,
      bool isValid,
      bool isSubmitting,
      bool isValidating,
      bool validateOnChange,
      bool validateOnBlur,
      List<String>? internalKeysChanged,
      String internalAName,
      String internalAType});
}

class _$FormFieldCopyWithImpl<Key, F extends FormFieldObject<F>, O>
    implements $FormFieldCopyWith<Key, F, O> {
  final FormField<Key, F> _value;
  final O Function(FormField<Key, F>) _then;
  _$FormFieldCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? value = dimmutable,
      Object? validators = dimmutable,
      Object? errors = dimmutable,
      Object? touched = dimmutable,
      Object? isValid = dimmutable,
      Object? isSubmitting = dimmutable,
      Object? isValidating = dimmutable,
      Object? validateOnChange = dimmutable,
      Object? validateOnBlur = dimmutable,
      Object? internalKeysChanged = dimmutable,
      Object? internalAName = dimmutable,
      Object? internalAType = dimmutable}) {
    return _then(_value.copyWith(
        value: value == dimmutable ? _value.value : value as F,
        validators: validators == dimmutable
            ? _value.validators
            : validators as Map<String, Function>,
        errors: errors == dimmutable
            ? _value.errors
            : errors as Map<String, String>,
        touched: touched == dimmutable
            ? _value.touched
            : touched as Map<String, bool>,
        isValid: isValid == dimmutable ? _value.isValid : isValid as bool,
        isSubmitting: isSubmitting == dimmutable
            ? _value.isSubmitting
            : isSubmitting as bool,
        isValidating: isValidating == dimmutable
            ? _value.isValidating
            : isValidating as bool,
        validateOnChange: validateOnChange == dimmutable
            ? _value.validateOnChange
            : validateOnChange as bool,
        validateOnBlur: validateOnBlur == dimmutable
            ? _value.validateOnBlur
            : validateOnBlur as bool,
        internalKeysChanged: internalKeysChanged == dimmutable
            ? _value.internalKeysChanged
            : internalKeysChanged as List<String>?,
        internalAName: internalAName == dimmutable
            ? _value.internalAName
            : internalAName as String,
        internalAType: internalAType == dimmutable
            ? _value.internalAType
            : internalAType as String));
  }
}

abstract class _$FormFieldCopyWith<Key, F extends FormFieldObject<F>, O>
    implements $FormFieldCopyWith<Key, F, O> {
  factory _$FormFieldCopyWith(
          FormField<Key, F> value, O Function(FormField<Key, F>) then) =
      __$FormFieldCopyWithImpl<Key, F, O>;
  O call(
      {F value,
      Map<String, Function> validators,
      Map<String, String> errors,
      Map<String, bool> touched,
      bool isValid,
      bool isSubmitting,
      bool isValidating,
      bool validateOnChange,
      bool validateOnBlur,
      List<String>? internalKeysChanged,
      String internalAName,
      String internalAType});
}

class __$FormFieldCopyWithImpl<Key, F extends FormFieldObject<F>, O>
    extends _$FormFieldCopyWithImpl<Key, F, O>
    implements _$FormFieldCopyWith<Key, F, O> {
  __$FormFieldCopyWithImpl(
      FormField<Key, F> _value, O Function(FormField<Key, F>) _then)
      : super(_value, (v) => _then(v));

  @override
  FormField<Key, F> get _value => super._value;

  @override
  O call(
      {Object? value = dimmutable,
      Object? validators = dimmutable,
      Object? errors = dimmutable,
      Object? touched = dimmutable,
      Object? isValid = dimmutable,
      Object? isSubmitting = dimmutable,
      Object? isValidating = dimmutable,
      Object? validateOnChange = dimmutable,
      Object? validateOnBlur = dimmutable,
      Object? internalKeysChanged = dimmutable,
      Object? internalAName = dimmutable,
      Object? internalAType = dimmutable}) {
    return _then(FormField(
        value: value == dimmutable ? _value.value : value as F,
        validators: validators == dimmutable
            ? _value.validators
            : validators as Map<String, Function>,
        errors: errors == dimmutable
            ? _value.errors
            : errors as Map<String, String>,
        touched: touched == dimmutable
            ? _value.touched
            : touched as Map<String, bool>,
        isValid: isValid == dimmutable ? _value.isValid : isValid as bool,
        isSubmitting: isSubmitting == dimmutable
            ? _value.isSubmitting
            : isSubmitting as bool,
        isValidating: isValidating == dimmutable
            ? _value.isValidating
            : isValidating as bool,
        validateOnChange: validateOnChange == dimmutable
            ? _value.validateOnChange
            : validateOnChange as bool,
        validateOnBlur: validateOnBlur == dimmutable
            ? _value.validateOnBlur
            : validateOnBlur as bool,
        internalKeysChanged: internalKeysChanged == dimmutable
            ? _value.internalKeysChanged
            : internalKeysChanged as List<String>?,
        internalAName: internalAName == dimmutable
            ? _value.internalAName
            : internalAName as String,
        internalAType: internalAType == dimmutable
            ? _value.internalAType
            : internalAType as String));
  }
}
