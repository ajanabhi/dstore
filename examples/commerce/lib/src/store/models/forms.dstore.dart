// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'forms.dart';

// **************************************************************************
// FormModelGenerator
// **************************************************************************

@immutable
class LoginForm implements FormFieldObject<LoginForm> {
  @Validator(ValidationUtils.validateMobile)
  final String phonenUmber;

  _$LoginFormCopyWith<LoginForm> get copyWith =>
      __$LoginFormCopyWithImpl<LoginForm>(this, IdentityFn);

  const LoginForm({this.phonenUmber = ""});

  @override
  LoginForm copyWithMap(Map<String, dynamic> map) => LoginForm(
      phonenUmber: map.containsKey("phonenUmber")
          ? map["phonenUmber"] as String
          : this.phonenUmber);

  Map<String, dynamic> toMap() =>
      <String, dynamic>{"phonenUmber": this.phonenUmber};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LoginForm && o.phonenUmber == phonenUmber;
  }

  @override
  int get hashCode => phonenUmber.hashCode;

  @override
  String toString() => "LoginForm(phonenUmber: ${this.phonenUmber})";
}

abstract class $LoginFormCopyWith<O> {
  factory $LoginFormCopyWith(LoginForm value, O Function(LoginForm) then) =
      _$LoginFormCopyWithImpl<O>;
  O call({String phonenUmber});
}

class _$LoginFormCopyWithImpl<O> implements $LoginFormCopyWith<O> {
  final LoginForm _value;
  final O Function(LoginForm) _then;
  _$LoginFormCopyWithImpl(this._value, this._then);

  @override
  O call({Object? phonenUmber = dimmutable}) {
    return _then(_value.copyWith(
        phonenUmber: phonenUmber == dimmutable
            ? _value.phonenUmber
            : phonenUmber as String));
  }
}

abstract class _$LoginFormCopyWith<O> implements $LoginFormCopyWith<O> {
  factory _$LoginFormCopyWith(LoginForm value, O Function(LoginForm) then) =
      __$LoginFormCopyWithImpl<O>;
  O call({String phonenUmber});
}

class __$LoginFormCopyWithImpl<O> extends _$LoginFormCopyWithImpl<O>
    implements _$LoginFormCopyWith<O> {
  __$LoginFormCopyWithImpl(LoginForm _value, O Function(LoginForm) _then)
      : super(_value, (v) => _then(v));

  @override
  LoginForm get _value => super._value;

  @override
  O call({Object? phonenUmber = dimmutable}) {
    return _then(LoginForm(
        phonenUmber: phonenUmber == dimmutable
            ? _value.phonenUmber
            : phonenUmber as String));
  }
}

enum LoginFormKey { phonenUmber }

const LoginFormValidators = <String, FormFieldValidator>{
  "phonenUmber": ValidationUtils.validateMobile
};
