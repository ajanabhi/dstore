// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class Auth implements PStateModel<Auth> {
  final User? user;

  _$AuthCopyWith<Auth> get copyWith =>
      __$AuthCopyWithImpl<Auth>(this, IdentityFn);

  const Auth({this.user = null});

  @override
  Auth copyWithMap(Map<String, dynamic> map) =>
      Auth(user: map.containsKey("user") ? map["user"] : this.user);

  Map<String, dynamic> toMap() => {"user": this.user};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Auth && o.user == user;
  }

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => "Auth(user: ${this.user})";
}

abstract class $AuthCopyWith<O> {
  factory $AuthCopyWith(Auth value, O Function(Auth) then) =
      _$AuthCopyWithImpl<O>;
  O call({User? user});
}

class _$AuthCopyWithImpl<O> implements $AuthCopyWith<O> {
  final Auth _value;
  final O Function(Auth) _then;
  _$AuthCopyWithImpl(this._value, this._then);

  @override
  O call({Object? user = dimmutable}) {
    return _then(_value.copyWith(
        user: user == dimmutable ? _value.user : user as User?));
  }
}

abstract class _$AuthCopyWith<O> implements $AuthCopyWith<O> {
  factory _$AuthCopyWith(Auth value, O Function(Auth) then) =
      __$AuthCopyWithImpl<O>;
  O call({User? user});
}

class __$AuthCopyWithImpl<O> extends _$AuthCopyWithImpl<O>
    implements _$AuthCopyWith<O> {
  __$AuthCopyWithImpl(Auth _value, O Function(Auth) _then)
      : super(_value, (v) => _then(v));

  @override
  Auth get _value => super._value;

  @override
  O call({Object? user = dimmutable}) {
    return _then(Auth(user: user == dimmutable ? _value.user : user as User?));
  }
}

abstract class AuthActions {}

Auth Auth_DS() => Auth(user: null);

final AuthMeta =
    PStateMeta<Auth>(type: "/store/pstates/auth/Auth", ds: Auth_DS);
