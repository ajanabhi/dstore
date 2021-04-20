// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local.dart';

// **************************************************************************
// GraphqlSchemaGenerator
// **************************************************************************

enum Screen { lg, sm }
enum Enum1 { HIGH, LOW }
enum CacheControlScope { PUBLIC, PRIVATE }
enum __TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL
}
enum __DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION
}

@JsonSerializable()
class Input1 {
  final String? name;

  final List<dynamic?>? inputs;

  @JsonKey(ignore: true)
  _$Input1CopyWith<Input1> get copyWith =>
      __$Input1CopyWithImpl<Input1>(this, IdentityFn);

  const Input1({this.name, this.inputs});

  factory Input1.fromJson(Map<String, dynamic> json) => _$Input1FromJson(json);

  Map<String, dynamic> toJson() => _$Input1ToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Input1 && o.name == name && o.inputs == inputs;
  }

  @override
  int get hashCode => name.hashCode ^ inputs.hashCode;

  @override
  String toString() => "Input1(name: ${this.name}, inputs: ${this.inputs})";
}

abstract class $Input1CopyWith<O> {
  factory $Input1CopyWith(Input1 value, O Function(Input1) then) =
      _$Input1CopyWithImpl<O>;
  O call({String? name, List<dynamic?>? inputs});
}

class _$Input1CopyWithImpl<O> implements $Input1CopyWith<O> {
  final Input1 _value;
  final O Function(Input1) _then;
  _$Input1CopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable, Object? inputs = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String?,
        inputs:
            inputs == dimmutable ? _value.inputs : inputs as List<dynamic?>?));
  }
}

abstract class _$Input1CopyWith<O> implements $Input1CopyWith<O> {
  factory _$Input1CopyWith(Input1 value, O Function(Input1) then) =
      __$Input1CopyWithImpl<O>;
  O call({String? name, List<dynamic?>? inputs});
}

class __$Input1CopyWithImpl<O> extends _$Input1CopyWithImpl<O>
    implements _$Input1CopyWith<O> {
  __$Input1CopyWithImpl(Input1 _value, O Function(Input1) _then)
      : super(_value, (v) => _then(v));

  @override
  Input1 get _value => super._value;

  @override
  O call({Object? name = dimmutable, Object? inputs = dimmutable}) {
    return _then(Input1(
        name: name == dimmutable ? _value.name : name as String?,
        inputs:
            inputs == dimmutable ? _value.inputs : inputs as List<dynamic?>?));
  }
}
