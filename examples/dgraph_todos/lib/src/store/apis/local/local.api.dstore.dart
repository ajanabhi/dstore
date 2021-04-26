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

class Todo {
  void text({String? alias, String? directive}) {}
  void d__typename;
}

class Person {
  void name({String? alias, String? directive}) {}
  void screen(Screen screen, {String? alias, String? directive}) {}
  void tags({String? alias, String? directive}) {}
  void screens(Screen screens, {String? alias, String? directive}) {}
  void hello(HelloU hello, {String? alias, String? directive}) {}
  void helloa(HelloU helloa, {String? alias, String? directive}) {}
  void address(Address address, {String? alias, String? directive}) {}
  void d__typename;
}

class Address {
  void street({String? alias, String? directive}) {}
  void zip({String? alias, String? directive}) {}
  void country(Country country, {String? alias, String? directive}) {}
  void d__typename;
}

class Country {
  void code({String? alias, String? directive}) {}
  void name({String? alias, String? directive}) {}
  void d__typename;
}

class Hello1 {
  void name({String? alias, String? directive}) {}
  void one({String? alias, String? directive}) {}
  void d__typename;
}

class Hello2 {
  void name({String? alias, String? directive}) {}
  void two({String? alias, String? directive}) {}
  void d__typename;
}

class Employee {
  void name({String? max, String? alias, String? directive}) {}
  void salary({String? alias, String? directive}) {}
  void d__typename;
}

class Query {
  Query([String? args]);
  void hello({String? alias, String? directive}) {}
  void hello1({String? alias, String? directive}) {}
  void ping({String? alias, String? directive}) {}
  void users(Person users, {String? alias, String? directive}) {}
  void na(Person na, {String? alias, String? directive}) {}
  void todo(Todo todo, {String? alias, String? directive}) {}
  void a({String? value, String? alias, String? directive}) {}
  void hellou(HelloU hellou, {String? alias, String? directive}) {}
  void inputArgsQ(
      {String? name,
      String? nameR,
      String? input1,
      String? ids,
      String? idsN,
      String? idsN2,
      String? eR,
      String? e,
      String? aa,
      String? alias,
      String? directive}) {}
  void d__typename;
}

class Subscription {
  Subscription([String? args]);
  void messageAdded({String? alias, String? directive}) {}
  void d__typename;
}

class __Schema {
  void description({String? alias, String? directive}) {}
  void types(__Type types, {String? alias, String? directive}) {}
  void queryType(__Type queryType, {String? alias, String? directive}) {}
  void mutationType(__Type mutationType, {String? alias, String? directive}) {}
  void subscriptionType(__Type subscriptionType,
      {String? alias, String? directive}) {}
  void directives(__Directive directives, {String? alias, String? directive}) {}
  void d__typename;
}

class __Type {
  void kind(__TypeKind kind, {String? alias, String? directive}) {}
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void specifiedByUrl({String? alias, String? directive}) {}
  void fields(__Field fields,
      {String? includeDeprecated, String? alias, String? directive}) {}
  void interfaces(__Type interfaces, {String? alias, String? directive}) {}
  void possibleTypes(__Type possibleTypes,
      {String? alias, String? directive}) {}
  void enumValues(__EnumValue enumValues,
      {String? includeDeprecated, String? alias, String? directive}) {}
  void inputFields(__InputValue inputFields,
      {String? includeDeprecated, String? alias, String? directive}) {}
  void ofType(__Type ofType, {String? alias, String? directive}) {}
  void d__typename;
}

class __Field {
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void args(__InputValue args,
      {String? includeDeprecated, String? alias, String? directive}) {}
  void type(__Type type, {String? alias, String? directive}) {}
  void isDeprecated({String? alias, String? directive}) {}
  void deprecationReason({String? alias, String? directive}) {}
  void d__typename;
}

class __InputValue {
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void type(__Type type, {String? alias, String? directive}) {}
  void defaultValue({String? alias, String? directive}) {}
  void isDeprecated({String? alias, String? directive}) {}
  void deprecationReason({String? alias, String? directive}) {}
  void d__typename;
}

class __EnumValue {
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void isDeprecated({String? alias, String? directive}) {}
  void deprecationReason({String? alias, String? directive}) {}
  void d__typename;
}

class __Directive {
  void name({String? alias, String? directive}) {}
  void description({String? alias, String? directive}) {}
  void isRepeatable({String? alias, String? directive}) {}
  void locations(__DirectiveLocation locations,
      {String? alias, String? directive}) {}
  void args(__InputValue args, {String? alias, String? directive}) {}
  void d__typename;
}

class HelloU {
  void unionfrag_Hello1(Hello1 value) {}
  void unionfrag_Hello2(Hello2 value) {}
}

class PersonI {
  void name({String? max, String? alias, String? directive}) {}
  void interfacefrag_Employee(Employee value) {}
}
