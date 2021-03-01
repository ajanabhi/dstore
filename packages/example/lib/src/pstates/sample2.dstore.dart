// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample2.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$TU {
  String get name;
  void Function(void Function(String), void Function(int), Object?, Object?,
      Object?, Object?, Object?, Object?, Object?) get u;
  String? get h;

  @JsonKey(ignore: true)
  $TUCopyWith<TU> get copyWith;
}

class _TU implements TU {
  @override
  final String name;

  @override
  final void Function(void Function(String), void Function(int), Object?,
      Object?, Object?, Object?, Object?, Object?, Object?) u;

  @override
  final String? h;

  @JsonKey(ignore: true)
  _$TUCopyWith<TU> get copyWith => __$TUCopyWithImpl<TU>(this, IdentityFn);

  const _TU({required this.name, required this.u, this.h});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _TU && o.name == name && o.u == u && o.h == h;
  }

  @override
  int get hashCode => name.hashCode ^ u.hashCode ^ h.hashCode;

  @override
  String toString() => "TU(name: ${this.name}, u: ${this.u}, h: ${this.h})";
}

abstract class $TUCopyWith<O> {
  factory $TUCopyWith(TU value, O Function(TU) then) = _$TUCopyWithImpl<O>;
  O call(
      {String name,
      void Function(void Function(String), void Function(int), Object?, Object?,
              Object?, Object?, Object?, Object?, Object?)
          u,
      String? h});
}

class _$TUCopyWithImpl<O> implements $TUCopyWith<O> {
  final TU _value;
  final O Function(TU) _then;
  _$TUCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? u = dimmutable,
      Object? h = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        u: u == dimmutable
            ? _value.u
            : u as void Function(void Function(String), void Function(int),
                Object?, Object?, Object?, Object?, Object?, Object?, Object?),
        h: h == dimmutable ? _value.h : h as String?));
  }
}

abstract class _$TUCopyWith<O> implements $TUCopyWith<O> {
  factory _$TUCopyWith(TU value, O Function(TU) then) = __$TUCopyWithImpl<O>;
  O call(
      {String name,
      void Function(void Function(String), void Function(int), Object?, Object?,
              Object?, Object?, Object?, Object?, Object?)
          u,
      String? h});
}

class __$TUCopyWithImpl<O> extends _$TUCopyWithImpl<O>
    implements _$TUCopyWith<O> {
  __$TUCopyWithImpl(TU _value, O Function(TU) _then)
      : super(_value, (v) => _then(v));

  @override
  TU get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? u = dimmutable,
      Object? h = dimmutable}) {
    return _then(TU(
        name: name == dimmutable ? _value.name : name as String,
        u: u == dimmutable
            ? _value.u
            : u as void Function(void Function(String), void Function(int),
                Object?, Object?, Object?, Object?, Object?, Object?, Object?),
        h: h == dimmutable ? _value.h : h as String?));
  }
}
