// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$User {
  String get name;

  $UserCopyWith<User> get copyWith;
}

class _User implements User {
  @override
  final String name;

  _$UserCopyWith<User> get copyWith =>
      __$UserCopyWithImpl<User>(this, IdentityFn);

  const _User({required this.name});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _User && o.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "User(name: ${this.name})";
}

abstract class $UserCopyWith<O> {
  factory $UserCopyWith(User value, O Function(User) then) =
      _$UserCopyWithImpl<O>;
  O call({String name});
}

class _$UserCopyWithImpl<O> implements $UserCopyWith<O> {
  final User _value;
  final O Function(User) _then;
  _$UserCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String));
  }
}

abstract class _$UserCopyWith<O> implements $UserCopyWith<O> {
  factory _$UserCopyWith(User value, O Function(User) then) =
      __$UserCopyWithImpl<O>;
  O call({String name});
}

class __$UserCopyWithImpl<O> extends _$UserCopyWithImpl<O>
    implements _$UserCopyWith<O> {
  __$UserCopyWithImpl(User _value, O Function(User) _then)
      : super(_value, (v) => _then(v));

  @override
  User get _value => super._value;

  @override
  O call({Object? name = dimmutable}) {
    return _then(User(name: name == dimmutable ? _value.name : name as String));
  }
}

mixin _$P2 {
  String get name;
  int get age;
  int? get a2;

  $P2CopyWith<P2> get copyWith;
}

class _P2 implements P2 {
  @override
  final String name;

  @override
  final int age;

  @override
  final int? a2;

  _$P2CopyWith<P2> get copyWith => __$P2CopyWithImpl<P2>(this, IdentityFn);

  const _P2({required this.name, required this.age, this.a2});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _P2 && o.name == name && o.age == age && o.a2 == a2;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ a2.hashCode;

  @override
  String toString() =>
      "P2(name: ${this.name}, age: ${this.age}, a2: ${this.a2})";
}

abstract class $P2CopyWith<O> {
  factory $P2CopyWith(P2 value, O Function(P2) then) = _$P2CopyWithImpl<O>;
  O call({String name, int age, int? a2});
}

class _$P2CopyWithImpl<O> implements $P2CopyWith<O> {
  final P2 _value;
  final O Function(P2) _then;
  _$P2CopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? age = dimmutable,
      Object? a2 = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int,
        a2: a2 == dimmutable ? _value.a2 : a2 as int?));
  }
}

abstract class _$P2CopyWith<O> implements $P2CopyWith<O> {
  factory _$P2CopyWith(P2 value, O Function(P2) then) = __$P2CopyWithImpl<O>;
  O call({String name, int age, int? a2});
}

class __$P2CopyWithImpl<O> extends _$P2CopyWithImpl<O>
    implements _$P2CopyWith<O> {
  __$P2CopyWithImpl(P2 _value, O Function(P2) _then)
      : super(_value, (v) => _then(v));

  @override
  P2 get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? age = dimmutable,
      Object? a2 = dimmutable}) {
    return _then(P2(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int,
        a2: a2 == dimmutable ? _value.a2 : a2 as int?));
  }
}
