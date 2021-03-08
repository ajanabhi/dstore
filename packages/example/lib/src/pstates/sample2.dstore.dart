// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample2.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$TU {
  String get s;
  String get h2;
  String get h;

  @JsonKey(ignore: true)
  $TUCopyWith<TU> get copyWith;
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _TU implements TU {
  @override
  final String s;

  @override
  @JsonKey(nullable: true, defaultValue: "2")
  @Default("hello2")
  final String h2;

  @override
  @Default("hello")
  @JsonKey(defaultValue: "hello")
  final String h;

  @JsonKey(ignore: true)
  _$TUCopyWith<TU> get copyWith => __$TUCopyWithImpl<TU>(this, IdentityFn);

  const _TU({required this.s, this.h2 = "hello2", this.h = "hello"});

  factory _TU.fromJson(Map<String, dynamic> json) => _$_TUFromJson(json);

  Map<String, dynamic> toJson() => _$_TUToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _TU && o.s == s && o.h2 == h2 && o.h == h;
  }

  @override
  int get hashCode => s.hashCode ^ h2.hashCode ^ h.hashCode;

  @override
  String toString() => "TU(s: ${this.s}, h2: ${this.h2}, h: ${this.h})";
}

TU _$TUFromJson(Map<String, dynamic> json) => _TU.fromJson(json);

abstract class $TUCopyWith<O> {
  factory $TUCopyWith(TU value, O Function(TU) then) = _$TUCopyWithImpl<O>;
  O call({String s, String h2, String h});
}

class _$TUCopyWithImpl<O> implements $TUCopyWith<O> {
  final TU _value;
  final O Function(TU) _then;
  _$TUCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? s = dimmutable,
      Object? h2 = dimmutable,
      Object? h = dimmutable}) {
    return _then(_value.copyWith(
        s: s == dimmutable ? _value.s : s as String,
        h2: h2 == dimmutable ? _value.h2 : h2 as String,
        h: h == dimmutable ? _value.h : h as String));
  }
}

abstract class _$TUCopyWith<O> implements $TUCopyWith<O> {
  factory _$TUCopyWith(TU value, O Function(TU) then) = __$TUCopyWithImpl<O>;
  O call({String s, String h2, String h});
}

class __$TUCopyWithImpl<O> extends _$TUCopyWithImpl<O>
    implements _$TUCopyWith<O> {
  __$TUCopyWithImpl(TU _value, O Function(TU) _then)
      : super(_value, (v) => _then(v));

  @override
  TU get _value => super._value;

  @override
  O call(
      {Object? s = dimmutable,
      Object? h2 = dimmutable,
      Object? h = dimmutable}) {
    return _then(TU(
        s: s == dimmutable ? _value.s : s as String,
        h2: h2 == dimmutable ? _value.h2 : h2 as String,
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
