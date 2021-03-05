// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample2.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$TU<S extends TU<dynamic>> {
  S get s;
  String get h;

  $TUCopyWith<S, TU<S>> get copyWith;
}

class _TU<S extends TU<dynamic>> implements TU<S> {
  @override
  final S s;

  @override
  @Default("hello")
  @JsonKey(defaultValue: "hello")
  final String h;

  _$TUCopyWith<S, TU<S>> get copyWith =>
      __$TUCopyWithImpl<S, TU<S>>(this, IdentityFn);

  const _TU({required this.s, this.h = "hello"});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _TU && o.s == s && o.h == h;
  }

  @override
  int get hashCode => s.hashCode ^ h.hashCode;

  @override
  String toString() => "TU(s: ${this.s}, h: ${this.h})";
}

abstract class $TUCopyWith<S extends TU<dynamic>, O> {
  factory $TUCopyWith(TU<S> value, O Function(TU<S>) then) =
      _$TUCopyWithImpl<S, O>;
  O call({S s, String h});
}

class _$TUCopyWithImpl<S extends TU<dynamic>, O> implements $TUCopyWith<S, O> {
  final TU<S> _value;
  final O Function(TU<S>) _then;
  _$TUCopyWithImpl(this._value, this._then);

  @override
  O call({Object? s = dimmutable, Object? h = dimmutable}) {
    return _then(_value.copyWith(
        s: s == dimmutable ? _value.s : s as S,
        h: h == dimmutable ? _value.h : h as String));
  }
}

abstract class _$TUCopyWith<S extends TU<dynamic>, O>
    implements $TUCopyWith<S, O> {
  factory _$TUCopyWith(TU<S> value, O Function(TU<S>) then) =
      __$TUCopyWithImpl<S, O>;
  O call({S s, String h});
}

class __$TUCopyWithImpl<S extends TU<dynamic>, O> extends _$TUCopyWithImpl<S, O>
    implements _$TUCopyWith<S, O> {
  __$TUCopyWithImpl(TU<S> _value, O Function(TU<S>) _then)
      : super(_value, (v) => _then(v));

  @override
  TU<S> get _value => super._value;

  @override
  O call({Object? s = dimmutable, Object? h = dimmutable}) {
    return _then(TU(
        s: s == dimmutable ? _value.s : s as S,
        h: h == dimmutable ? _value.h : h as String));
  }
}

mixin _$Hello {
  String get name;

  $HelloCopyWith<Hello> get copyWith;
}

class _Hello implements Hello {
  @override
  final String name;

  _$HelloCopyWith<Hello> get copyWith =>
      __$HelloCopyWithImpl<Hello>(this, IdentityFn);

  const _Hello({required this.name});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _Hello && o.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "Hello(name: ${this.name})";
}

abstract class $HelloCopyWith<O> {
  factory $HelloCopyWith(Hello value, O Function(Hello) then) =
      _$HelloCopyWithImpl<O>;
  O call({String name});
}

class _$HelloCopyWithImpl<O> implements $HelloCopyWith<O> {
  final Hello _value;
  final O Function(Hello) _then;
  _$HelloCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String));
  }
}

abstract class _$HelloCopyWith<O> implements $HelloCopyWith<O> {
  factory _$HelloCopyWith(Hello value, O Function(Hello) then) =
      __$HelloCopyWithImpl<O>;
  O call({String name});
}

class __$HelloCopyWithImpl<O> extends _$HelloCopyWithImpl<O>
    implements _$HelloCopyWith<O> {
  __$HelloCopyWithImpl(Hello _value, O Function(Hello) _then)
      : super(_value, (v) => _then(v));

  @override
  Hello get _value => super._value;

  @override
  O call({Object? name = dimmutable}) {
    return _then(
        Hello(name: name == dimmutable ? _value.name : name as String));
  }
}
