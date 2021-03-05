// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'selector_sample.dart';

// **************************************************************************
// SelectorsGenerator
// **************************************************************************

// Selector
class AppSelectors {
  static final hello = Selector<AppState, S1>(fn: _AppSelectors.hello, deps: {
    "sample": ["name", "s", "sf", "wm", "fint"]
  }, wsDeps: {
    "sample": ["wm"]
  }, sfDeps: {
    "sample": ["sf"]
  });
}

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$S1 {
  String get name;
  int get s;
  String? get op3;

  $S1CopyWith<S1> get copyWith;
}

class _S1 implements S1 {
  @override
  final String name;

  @override
  final int s;

  @override
  final String? op3;

  _$S1CopyWith<S1> get copyWith => __$S1CopyWithImpl<S1>(this, IdentityFn);

  const _S1({required this.name, required this.s, this.op3});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _S1 && o.name == name && o.s == s && o.op3 == op3;
  }

  @override
  int get hashCode => name.hashCode ^ s.hashCode ^ op3.hashCode;

  @override
  String toString() => "S1(name: ${this.name}, s: ${this.s}, op3: ${this.op3})";
}

abstract class $S1CopyWith<O> {
  factory $S1CopyWith(S1 value, O Function(S1) then) = _$S1CopyWithImpl<O>;
  O call({String name, int s, String? op3});
}

class _$S1CopyWithImpl<O> implements $S1CopyWith<O> {
  final S1 _value;
  final O Function(S1) _then;
  _$S1CopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? s = dimmutable,
      Object? op3 = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        s: s == dimmutable ? _value.s : s as int,
        op3: op3 == dimmutable ? _value.op3 : op3 as String?));
  }
}

abstract class _$S1CopyWith<O> implements $S1CopyWith<O> {
  factory _$S1CopyWith(S1 value, O Function(S1) then) = __$S1CopyWithImpl<O>;
  O call({String name, int s, String? op3});
}

class __$S1CopyWithImpl<O> extends _$S1CopyWithImpl<O>
    implements _$S1CopyWith<O> {
  __$S1CopyWithImpl(S1 _value, O Function(S1) _then)
      : super(_value, (v) => _then(v));

  @override
  S1 get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? s = dimmutable,
      Object? op3 = dimmutable}) {
    return _then(S1(
        name: name == dimmutable ? _value.name : name as String,
        s: s == dimmutable ? _value.s : s as int,
        op3: op3 == dimmutable ? _value.op3 : op3 as String?));
  }
}
