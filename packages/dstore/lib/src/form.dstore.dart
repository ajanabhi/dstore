// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'form.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$FormField<F extends FormFieldObject<dynamic>> {
  F get value;
  Map<String, dynamic Function(dynamic)> get validators;
  Map<String, String> get errors;
  Map<String, bool> get touched;
  bool get isValid;
  bool get isSubmitting;
  bool get isValidating;
  bool get validateOnChange;
  bool get validateOnBlur;
  String get internalAName;
  Type get internalAType;

  $FormFieldCopyWith<F, FormField<F>> get copyWith;
}

class _FormField<F extends FormFieldObject<dynamic>> implements FormField<F> {
  @override
  final F value;

  @override
  final Map<String, dynamic Function(dynamic)> validators;

  @override
  @Default({})
  @JsonKey(defaultValue: const {})
  final Map<String, String> errors;

  @override
  @Default({})
  @JsonKey(defaultValue: const {})
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
  @Default("")
  @JsonKey(defaultValue: "")
  final String internalAName;

  @override
  @Default(Object)
  @JsonKey(defaultValue: Object)
  final Type internalAType;

  _$FormFieldCopyWith<F, FormField<F>> get copyWith =>
      __$FormFieldCopyWithImpl<F, FormField<F>>(this, IdentityFn);

  const _FormField(
      {required this.value,
      required this.validators,
      this.errors = const {},
      this.touched = const {},
      this.isValid = false,
      this.isSubmitting = false,
      this.isValidating = false,
      this.validateOnChange = false,
      this.validateOnBlur = false,
      this.internalAName = "",
      this.internalAType = Object});

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
      internalAName.hashCode ^
      internalAType.hashCode;

  @override
  String toString() =>
      "FormField(value: ${this.value}, validators: ${this.validators}, errors: ${this.errors}, touched: ${this.touched}, isValid: ${this.isValid}, isSubmitting: ${this.isSubmitting}, isValidating: ${this.isValidating}, validateOnChange: ${this.validateOnChange}, validateOnBlur: ${this.validateOnBlur}, internalAName: ${this.internalAName}, internalAType: ${this.internalAType})";
}

abstract class $FormFieldCopyWith<F extends FormFieldObject<dynamic>, O> {
  factory $FormFieldCopyWith(
          FormField<F> value, O Function(FormField<F>) then) =
      _$FormFieldCopyWithImpl<F, O>;
  O call(
      {F value,
      Map<String, dynamic Function(dynamic)> validators,
      Map<String, String> errors,
      Map<String, bool> touched,
      bool isValid,
      bool isSubmitting,
      bool isValidating,
      bool validateOnChange,
      bool validateOnBlur,
      String internalAName,
      Type internalAType});
}

class _$FormFieldCopyWithImpl<F extends FormFieldObject<dynamic>, O>
    implements $FormFieldCopyWith<F, O> {
  final FormField<F> _value;
  final O Function(FormField<F>) _then;
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
      Object? internalAName = dimmutable,
      Object? internalAType = dimmutable}) {
    return _then(_value.copyWith(
        value: value == dimmutable ? _value.value : value as F,
        validators: validators == dimmutable
            ? _value.validators
            : validators as Map<String, dynamic Function(dynamic)>,
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
        internalAName: internalAName == dimmutable
            ? _value.internalAName
            : internalAName as String,
        internalAType: internalAType == dimmutable
            ? _value.internalAType
            : internalAType as Type));
  }
}

abstract class _$FormFieldCopyWith<F extends FormFieldObject<dynamic>, O>
    implements $FormFieldCopyWith<F, O> {
  factory _$FormFieldCopyWith(
          FormField<F> value, O Function(FormField<F>) then) =
      __$FormFieldCopyWithImpl<F, O>;
  O call(
      {F value,
      Map<String, dynamic Function(dynamic)> validators,
      Map<String, String> errors,
      Map<String, bool> touched,
      bool isValid,
      bool isSubmitting,
      bool isValidating,
      bool validateOnChange,
      bool validateOnBlur,
      String internalAName,
      Type internalAType});
}

class __$FormFieldCopyWithImpl<F extends FormFieldObject<dynamic>, O>
    extends _$FormFieldCopyWithImpl<F, O> implements _$FormFieldCopyWith<F, O> {
  __$FormFieldCopyWithImpl(FormField<F> _value, O Function(FormField<F>) _then)
      : super(_value, (v) => _then(v));

  @override
  FormField<F> get _value => super._value;

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
      Object? internalAName = dimmutable,
      Object? internalAType = dimmutable}) {
    return _then(FormField(
        value: value == dimmutable ? _value.value : value as F,
        validators: validators == dimmutable
            ? _value.validators
            : validators as Map<String, dynamic Function(dynamic)>,
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
        internalAName: internalAName == dimmutable
            ? _value.internalAName
            : internalAName as String,
        internalAType: internalAType == dimmutable
            ? _value.internalAType
            : internalAType as Type));
  }
}