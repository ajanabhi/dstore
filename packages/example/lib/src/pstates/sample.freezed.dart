// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PersonTearOff {
  const _$PersonTearOff();

  _Person call({required String name, required int age, String? name2 = 2}) {
    return _Person(
      name: name,
      age: age,
      name2: name2,
    );
  }
}

/// @nodoc
const $Person = _$PersonTearOff();

/// @nodoc
mixin _$Person {
  String get name;
  int get age;
  String? get name2;

  @JsonKey(ignore: true)
  $PersonCopyWith<Person> get copyWith;
}

/// @nodoc
abstract class $PersonCopyWith<$Res> {
  factory $PersonCopyWith(Person value, $Res Function(Person) then) =
      _$PersonCopyWithImpl<$Res>;
  $Res call({String name, int age, String? name2});
}

/// @nodoc
class _$PersonCopyWithImpl<$Res> implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._value, this._then);

  final Person _value;
  // ignore: unused_field
  final $Res Function(Person) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
    Object? name2 = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      age: age == freezed ? _value.age : age as int,
      name2: name2 == freezed ? _value.name2 : name2 as String?,
    ));
  }
}

/// @nodoc
abstract class _$PersonCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$PersonCopyWith(_Person value, $Res Function(_Person) then) =
      __$PersonCopyWithImpl<$Res>;
  @override
  $Res call({String name, int age, String? name2});
}

/// @nodoc
class __$PersonCopyWithImpl<$Res> extends _$PersonCopyWithImpl<$Res>
    implements _$PersonCopyWith<$Res> {
  __$PersonCopyWithImpl(_Person _value, $Res Function(_Person) _then)
      : super(_value, (v) => _then(v as _Person));

  @override
  _Person get _value => super._value as _Person;

  @override
  $Res call({
    Object? name = freezed,
    Object? age = freezed,
    Object? name2 = freezed,
  }) {
    return _then(_Person(
      name: name == freezed ? _value.name : name as String,
      age: age == freezed ? _value.age : age as int,
      name2: name2 == freezed ? _value.name2 : name2 as String?,
    ));
  }
}

/// @nodoc
class _$_Person implements _Person {
  const _$_Person({required this.name, required this.age, this.name2 = 2});

  @override
  final String name;
  @override
  final int age;
  @JsonKey(defaultValue: 2)
  @override
  final String? name2;

  @override
  String toString() {
    return 'Person(name: $name, age: $age, name2: $name2)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Person &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.age, age) ||
                const DeepCollectionEquality().equals(other.age, age)) &&
            (identical(other.name2, name2) ||
                const DeepCollectionEquality().equals(other.name2, name2)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(age) ^
      const DeepCollectionEquality().hash(name2);

  @JsonKey(ignore: true)
  @override
  _$PersonCopyWith<_Person> get copyWith =>
      __$PersonCopyWithImpl<_Person>(this, _$identity);
}

abstract class _Person implements Person {
  const factory _Person(
      {required String name, required int age, String? name2}) = _$_Person;

  @override
  String get name;
  @override
  int get age;
  @override
  String? get name2;
  @override
  @JsonKey(ignore: true)
  _$PersonCopyWith<_Person> get copyWith;
}
