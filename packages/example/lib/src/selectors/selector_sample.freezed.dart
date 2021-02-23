// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'selector_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$S1FTearOff {
  const _$S1FTearOff();

  _S1F call({required String name, required int s, String? op3}) {
    return _S1F(
      name: name,
      s: s,
      op3: op3,
    );
  }
}

/// @nodoc
const $S1F = _$S1FTearOff();

/// @nodoc
mixin _$S1F {
  String get name;
  int get s;
  String? get op3;

  @JsonKey(ignore: true)
  $S1FCopyWith<S1F> get copyWith;
}

/// @nodoc
abstract class $S1FCopyWith<$Res> {
  factory $S1FCopyWith(S1F value, $Res Function(S1F) then) =
      _$S1FCopyWithImpl<$Res>;
  $Res call({String name, int s, String? op3});
}

/// @nodoc
class _$S1FCopyWithImpl<$Res> implements $S1FCopyWith<$Res> {
  _$S1FCopyWithImpl(this._value, this._then);

  final S1F _value;
  // ignore: unused_field
  final $Res Function(S1F) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? s = freezed,
    Object? op3 = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      s: s == freezed ? _value.s : s as int,
      op3: op3 == freezed ? _value.op3 : op3 as String?,
    ));
  }
}

/// @nodoc
abstract class _$S1FCopyWith<$Res> implements $S1FCopyWith<$Res> {
  factory _$S1FCopyWith(_S1F value, $Res Function(_S1F) then) =
      __$S1FCopyWithImpl<$Res>;
  @override
  $Res call({String name, int s, String? op3});
}

/// @nodoc
class __$S1FCopyWithImpl<$Res> extends _$S1FCopyWithImpl<$Res>
    implements _$S1FCopyWith<$Res> {
  __$S1FCopyWithImpl(_S1F _value, $Res Function(_S1F) _then)
      : super(_value, (v) => _then(v as _S1F));

  @override
  _S1F get _value => super._value as _S1F;

  @override
  $Res call({
    Object? name = freezed,
    Object? s = freezed,
    Object? op3 = freezed,
  }) {
    return _then(_S1F(
      name: name == freezed ? _value.name : name as String,
      s: s == freezed ? _value.s : s as int,
      op3: op3 == freezed ? _value.op3 : op3 as String?,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_S1F implements _S1F {
  const _$_S1F({required this.name, required this.s, this.op3});

  @override
  final String name;
  @override
  final int s;
  @override
  final String? op3;

  @override
  String toString() {
    return 'S1F(name: $name, s: $s, op3: $op3)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _S1F &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.s, s) ||
                const DeepCollectionEquality().equals(other.s, s)) &&
            (identical(other.op3, op3) ||
                const DeepCollectionEquality().equals(other.op3, op3)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(s) ^
      const DeepCollectionEquality().hash(op3);

  @JsonKey(ignore: true)
  @override
  _$S1FCopyWith<_S1F> get copyWith =>
      __$S1FCopyWithImpl<_S1F>(this, _$identity);
}

abstract class _S1F implements S1F {
  const factory _S1F({required String name, required int s, String? op3}) =
      _$_S1F;

  @override
  String get name;
  @override
  int get s;
  @override
  String? get op3;
  @override
  @JsonKey(ignore: true)
  _$S1FCopyWith<_S1F> get copyWith;
}
