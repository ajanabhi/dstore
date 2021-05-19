// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'form_state.dart';

// **************************************************************************
// FormModelGenerator
// **************************************************************************

@immutable
class SimpleForm implements FormFieldObject<SimpleForm> {
  final String name;

  final REnum? r;

  _$SimpleFormCopyWith<SimpleForm> get copyWith =>
      __$SimpleFormCopyWithImpl<SimpleForm>(this, IdentityFn);

  const SimpleForm({this.name = "initialName", this.r});

  @override
  SimpleForm copyWithMap(Map<String, dynamic> map) => SimpleForm(
      name: map.containsKey("name") ? map["name"] as String : this.name,
      r: map.containsKey("r") ? map["r"] as REnum? : this.r);

  Map<String, dynamic> toMap() =>
      <String, dynamic>{"name": this.name, "r": this.r};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is SimpleForm && o.name == name && o.r == r;
  }

  @override
  int get hashCode => name.hashCode ^ r.hashCode;

  @override
  String toString() => "SimpleForm(name: ${this.name}, r: ${this.r})";
}

abstract class $SimpleFormCopyWith<O> {
  factory $SimpleFormCopyWith(SimpleForm value, O Function(SimpleForm) then) =
      _$SimpleFormCopyWithImpl<O>;
  O call({String name, REnum? r});
}

class _$SimpleFormCopyWithImpl<O> implements $SimpleFormCopyWith<O> {
  final SimpleForm _value;
  final O Function(SimpleForm) _then;
  _$SimpleFormCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable, Object? r = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        r: r == dimmutable ? _value.r : r as REnum?));
  }
}

abstract class _$SimpleFormCopyWith<O> implements $SimpleFormCopyWith<O> {
  factory _$SimpleFormCopyWith(SimpleForm value, O Function(SimpleForm) then) =
      __$SimpleFormCopyWithImpl<O>;
  O call({String name, REnum? r});
}

class __$SimpleFormCopyWithImpl<O> extends _$SimpleFormCopyWithImpl<O>
    implements _$SimpleFormCopyWith<O> {
  __$SimpleFormCopyWithImpl(SimpleForm _value, O Function(SimpleForm) _then)
      : super(_value, (v) => _then(v));

  @override
  SimpleForm get _value => super._value;

  @override
  O call({Object? name = dimmutable, Object? r = dimmutable}) {
    return _then(SimpleForm(
        name: name == dimmutable ? _value.name : name as String,
        r: r == dimmutable ? _value.r : r as REnum?));
  }
}

enum SimpleFormKey { name, r }
