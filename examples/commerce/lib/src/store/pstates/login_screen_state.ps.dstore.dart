// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_screen_state.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class LoginScreenState extends PStateModel<LoginScreenState> {
  final FormField<LoginFormKey, LoginForm> loginForm;

  _$LoginScreenStateCopyWith<LoginScreenState> get copyWith =>
      __$LoginScreenStateCopyWithImpl<LoginScreenState>(this, IdentityFn);

  LoginScreenState(
      {this.loginForm = const FormField(
          value: LoginForm(),
          validateOnChange: true,
          validators: LoginFormValidators)});

  @override
  LoginScreenState copyWithMap(Map<String, dynamic> map) => LoginScreenState(
      loginForm:
          map.containsKey("loginForm") ? map["loginForm"] : this.loginForm);

  Map<String, dynamic> toMap() => {"loginForm": this.loginForm};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LoginScreenState && o.loginForm == loginForm;
  }

  @override
  int get hashCode => loginForm.hashCode;

  @override
  String toString() => "LoginScreenState(loginForm: ${this.loginForm})";
}

abstract class $LoginScreenStateCopyWith<O> {
  factory $LoginScreenStateCopyWith(
          LoginScreenState value, O Function(LoginScreenState) then) =
      _$LoginScreenStateCopyWithImpl<O>;
  O call({FormField<LoginFormKey, LoginForm> loginForm});
}

class _$LoginScreenStateCopyWithImpl<O>
    implements $LoginScreenStateCopyWith<O> {
  final LoginScreenState _value;
  final O Function(LoginScreenState) _then;
  _$LoginScreenStateCopyWithImpl(this._value, this._then);

  @override
  O call({Object? loginForm = dimmutable}) {
    return _then(_value.copyWith(
        loginForm: loginForm == dimmutable
            ? _value.loginForm
            : loginForm as FormField<LoginFormKey, LoginForm>));
  }
}

abstract class _$LoginScreenStateCopyWith<O>
    implements $LoginScreenStateCopyWith<O> {
  factory _$LoginScreenStateCopyWith(
          LoginScreenState value, O Function(LoginScreenState) then) =
      __$LoginScreenStateCopyWithImpl<O>;
  O call({FormField<LoginFormKey, LoginForm> loginForm});
}

class __$LoginScreenStateCopyWithImpl<O>
    extends _$LoginScreenStateCopyWithImpl<O>
    implements _$LoginScreenStateCopyWith<O> {
  __$LoginScreenStateCopyWithImpl(
      LoginScreenState _value, O Function(LoginScreenState) _then)
      : super(_value, (v) => _then(v));

  @override
  LoginScreenState get _value => super._value;

  @override
  O call({Object? loginForm = dimmutable}) {
    return _then(LoginScreenState(
        loginForm: loginForm == dimmutable
            ? _value.loginForm
            : loginForm as FormField<LoginFormKey, LoginForm>));
  }
}

const _LoginScreenState_FullPath =
    "/store/pstates/login_screen_state/LoginScreenState";

abstract class LoginScreenStateActions {
  static loginForm(FormReq req) {
    return Action(
        name:
            "Field(Name : loginForm Type : FormField<LoginFormKey, LoginForm> Value : FormField(value: LoginForm(), validateOnChange: true, validators: LoginFormValidators) isOptional : false annotations : []).name}",
        type: _LoginScreenState_FullPath,
        form: req);
  }
}

LoginScreenState LoginScreenState_DS() => LoginScreenState(
    loginForm: FormField(
        value: LoginForm(),
        validateOnChange: true,
        validators: LoginFormValidators,
        internalAName: "loginForm",
        internalAType: _LoginScreenState_FullPath));

final LoginScreenStateMeta = PStateMeta<LoginScreenState>(
    type: _LoginScreenState_FullPath, ds: LoginScreenState_DS);
