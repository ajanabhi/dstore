// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'models.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$Hello {
  String get name2;

  @JsonKey(ignore: true)
  $HelloCopyWith<Hello> get copyWith;
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _Hello implements Hello {
  @override
  final String name2;

  @JsonKey(ignore: true)
  _$HelloCopyWith<Hello> get copyWith =>
      __$HelloCopyWithImpl<Hello>(this, IdentityFn);

  const _Hello({required this.name2});

  factory _Hello.fromJson(Map<String, dynamic> json) => _$_HelloFromJson(json);

  Map<String, dynamic> toJson() => _$_HelloToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _Hello && o.name2 == name2;
  }

  @override
  int get hashCode => name2.hashCode;

  @override
  String toString() => "Hello(name2: ${this.name2})";
}

Hello _$HelloFromJson(Map<String, dynamic> json) => _Hello.fromJson(json);

abstract class $HelloCopyWith<O> {
  factory $HelloCopyWith(Hello value, O Function(Hello) then) =
      _$HelloCopyWithImpl<O>;
  O call({String name2});
}

class _$HelloCopyWithImpl<O> implements $HelloCopyWith<O> {
  final Hello _value;
  final O Function(Hello) _then;
  _$HelloCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name2 = dimmutable}) {
    return _then(_value.copyWith(
        name2: name2 == dimmutable ? _value.name2 : name2 as String));
  }
}

abstract class _$HelloCopyWith<O> implements $HelloCopyWith<O> {
  factory _$HelloCopyWith(Hello value, O Function(Hello) then) =
      __$HelloCopyWithImpl<O>;
  O call({String name2});
}

class __$HelloCopyWithImpl<O> extends _$HelloCopyWithImpl<O>
    implements _$HelloCopyWith<O> {
  __$HelloCopyWithImpl(Hello _value, O Function(Hello) _then)
      : super(_value, (v) => _then(v));

  @override
  Hello get _value => super._value;

  @override
  O call({Object? name2 = dimmutable}) {
    return _then(
        Hello(name2: name2 == dimmutable ? _value.name2 : name2 as String));
  }
}

mixin _$Hello2 {
  List<Hello> get hellos;
  Hello get h;
  int get age;

  @JsonKey(ignore: true)
  $Hello2CopyWith<Hello2> get copyWith;
  Map<String, dynamic> toJson();
}

@JsonSerializable(explicitToJson: true)
class _Hello2 implements Hello2 {
  @override
  final List<Hello> hellos;

  @override
  final Hello h;

  @override
  final int age;

  @JsonKey(ignore: true)
  _$Hello2CopyWith<Hello2> get copyWith =>
      __$Hello2CopyWithImpl<Hello2>(this, IdentityFn);

  const _Hello2({required this.hellos, required this.h, required this.age});

  factory _Hello2.fromJson(Map<String, dynamic> json) =>
      _$_Hello2FromJson(json);

  Map<String, dynamic> toJson() => _$_Hello2ToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _Hello2 && o.hellos == hellos && o.h == h && o.age == age;
  }

  @override
  int get hashCode => hellos.hashCode ^ h.hashCode ^ age.hashCode;

  @override
  String toString() =>
      "Hello2(hellos: ${this.hellos}, h: ${this.h}, age: ${this.age})";
}

Hello2 _$Hello2FromJson(Map<String, dynamic> json) => _Hello2.fromJson(json);

abstract class $Hello2CopyWith<O> {
  factory $Hello2CopyWith(Hello2 value, O Function(Hello2) then) =
      _$Hello2CopyWithImpl<O>;
  O call({List<Hello> hellos, Hello h, int age});
}

class _$Hello2CopyWithImpl<O> implements $Hello2CopyWith<O> {
  final Hello2 _value;
  final O Function(Hello2) _then;
  _$Hello2CopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? hellos = dimmutable,
      Object? h = dimmutable,
      Object? age = dimmutable}) {
    return _then(_value.copyWith(
        hellos: hellos == dimmutable ? _value.hellos : hellos as List<Hello>,
        h: h == dimmutable ? _value.h : h as Hello,
        age: age == dimmutable ? _value.age : age as int));
  }
}

abstract class _$Hello2CopyWith<O> implements $Hello2CopyWith<O> {
  factory _$Hello2CopyWith(Hello2 value, O Function(Hello2) then) =
      __$Hello2CopyWithImpl<O>;
  O call({List<Hello> hellos, Hello h, int age});
}

class __$Hello2CopyWithImpl<O> extends _$Hello2CopyWithImpl<O>
    implements _$Hello2CopyWith<O> {
  __$Hello2CopyWithImpl(Hello2 _value, O Function(Hello2) _then)
      : super(_value, (v) => _then(v));

  @override
  Hello2 get _value => super._value;

  @override
  O call(
      {Object? hellos = dimmutable,
      Object? h = dimmutable,
      Object? age = dimmutable}) {
    return _then(Hello2(
        hellos: hellos == dimmutable ? _value.hellos : hellos as List<Hello>,
        h: h == dimmutable ? _value.h : h as Hello,
        age: age == dimmutable ? _value.age : age as int));
  }
}
