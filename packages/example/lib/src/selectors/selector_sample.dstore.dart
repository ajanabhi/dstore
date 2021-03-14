// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'selector_sample.dart';

// **************************************************************************
// SelectorsGenerator
// **************************************************************************

// Selector
class AppSelectors {
  static final hello = Selector<AppState, S1>(fn: _AppSelectors.hello, deps: {
    "sample": ["name", "s", "fint"]
  });
  static final hello2 = Selector<AppState, dynamic>(
      fn: _AppSelectors.hello2, deps: {"sample2": [], "sample": []});
}

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$S1 {
  String get name;
  int get s;

  $S1CopyWith<S1> get copyWith;
}

class _S1 implements S1 {
  @override
  @JsonKey()
  final String name;

  @override
  @JsonKey(ignore: true)
  final int s;

  _$S1CopyWith<S1> get copyWith => __$S1CopyWithImpl<S1>(this, IdentityFn);

  const _S1({required this.name, required this.s});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _S1 && o.name == name && o.s == s;
  }

  @override
  int get hashCode => name.hashCode ^ s.hashCode;

  @override
  String toString() => "S1(name: ${this.name}, s: ${this.s})";
}

abstract class $S1CopyWith<O> {
  factory $S1CopyWith(S1 value, O Function(S1) then) = _$S1CopyWithImpl<O>;
  O call({String name, int s});
}

class _$S1CopyWithImpl<O> implements $S1CopyWith<O> {
  final S1 _value;
  final O Function(S1) _then;
  _$S1CopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable, Object? s = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        s: s == dimmutable ? _value.s : s as int));
  }
}

abstract class _$S1CopyWith<O> implements $S1CopyWith<O> {
  factory _$S1CopyWith(S1 value, O Function(S1) then) = __$S1CopyWithImpl<O>;
  O call({String name, int s});
}

class __$S1CopyWithImpl<O> extends _$S1CopyWithImpl<O>
    implements _$S1CopyWith<O> {
  __$S1CopyWithImpl(S1 _value, O Function(S1) _then)
      : super(_value, (v) => _then(v));

  @override
  S1 get _value => super._value;

  @override
  O call({Object? name = dimmutable, Object? s = dimmutable}) {
    return _then(S1(
        name: name == dimmutable ? _value.name : name as String,
        s: s == dimmutable ? _value.s : s as int));
  }
}
