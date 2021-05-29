// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_ops.dart';

// **************************************************************************
// GraphqlOpsGenerator
// **************************************************************************

@JsonSerializable()
class LocalOps_pingData {
  final String? ping;

  @JsonKey(ignore: true)
  _$LocalOps_pingDataCopyWith<LocalOps_pingData> get copyWith =>
      __$LocalOps_pingDataCopyWithImpl<LocalOps_pingData>(this, IdentityFn);

  const LocalOps_pingData({required this.ping});

  factory LocalOps_pingData.fromJson(Map<String, dynamic> json) =>
      _$LocalOps_pingDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocalOps_pingDataToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_pingData && o.ping == ping;
  }

  @override
  int get hashCode => ping.hashCode;

  @override
  String toString() => "LocalOps_pingData(ping: ${this.ping})";
}

abstract class $LocalOps_pingDataCopyWith<O> {
  factory $LocalOps_pingDataCopyWith(
          LocalOps_pingData value, O Function(LocalOps_pingData) then) =
      _$LocalOps_pingDataCopyWithImpl<O>;
  O call({String? ping});
}

class _$LocalOps_pingDataCopyWithImpl<O>
    implements $LocalOps_pingDataCopyWith<O> {
  final LocalOps_pingData _value;
  final O Function(LocalOps_pingData) _then;
  _$LocalOps_pingDataCopyWithImpl(this._value, this._then);

  @override
  O call({Object? ping = dimmutable}) {
    return _then(_value.copyWith(
        ping: ping == dimmutable ? _value.ping : ping as String?));
  }
}

abstract class _$LocalOps_pingDataCopyWith<O>
    implements $LocalOps_pingDataCopyWith<O> {
  factory _$LocalOps_pingDataCopyWith(
          LocalOps_pingData value, O Function(LocalOps_pingData) then) =
      __$LocalOps_pingDataCopyWithImpl<O>;
  O call({String? ping});
}

class __$LocalOps_pingDataCopyWithImpl<O>
    extends _$LocalOps_pingDataCopyWithImpl<O>
    implements _$LocalOps_pingDataCopyWith<O> {
  __$LocalOps_pingDataCopyWithImpl(
      LocalOps_pingData _value, O Function(LocalOps_pingData) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_pingData get _value => super._value;

  @override
  O call({Object? ping = dimmutable}) {
    return _then(LocalOps_pingData(
        ping: ping == dimmutable ? _value.ping : ping as String?));
  }
}

GraphqlRequestInput<Null> LocalOps_pingInputDeserializer(dynamic json) {
  return GraphqlRequestInput.fromJson(json as Map<String, dynamic>);
}

Map<String, dynamic> LocalOps_pingDataSerializer(
        int status, LocalOps_pingData resp) =>
    resp.toJson();

LocalOps_pingData LocalOps_pingDataDeserializer(int status, dynamic json) =>
    LocalOps_pingData.fromJson(json as Map<String, dynamic>);

@HttpRequest(
    method: "POST",
    url: "http://localhost:4000/graphql",
    graphqlQuery: GraphqlRequestPart(query: """query LocalOps_ping { 
 ping   
 
 }""", hash: null, useGetForPersist: false),
    responseType: HttpResponseType.JSON,
    headers: {"Content_Type": "applications/josn"},
    responseSerializer: LocalOps_pingDataSerializer,
    inputSerializer: GraphqlRequestInput.toJson,
    inputDeserializer: LocalOps_pingInputDeserializer,
    responseDeserializer: LocalOps_pingDataDeserializer)
typedef LocalOps_ping
    = HttpField<GraphqlRequestInput<Null>, LocalOps_pingData, String>;

@HttpRequest(
    method: "POST",
    url: "http://localhost:4000/graphql",
    graphqlQuery: GraphqlRequestPart(query: """query LocalOps_ping { 
 ping   
 
 }""", hash: null, useGetForPersist: false),
    responseType: HttpResponseType.JSON,
    headers: {"Content_Type": "applications/josn"},
    responseSerializer: LocalOps_pingDataSerializer,
    inputSerializer: GraphqlRequestInput.toJson,
    inputDeserializer: LocalOps_pingInputDeserializer,
    responseDeserializer: LocalOps_pingDataDeserializer)
typedef LocalOps_pingT<T> = HttpField<GraphqlRequestInput<Null>, T, String>;

@JsonSerializable()
class LocalOps_usersData {
  final List<LocalOps_usersData_users?>? users;

  @JsonKey(ignore: true)
  _$LocalOps_usersDataCopyWith<LocalOps_usersData> get copyWith =>
      __$LocalOps_usersDataCopyWithImpl<LocalOps_usersData>(this, IdentityFn);

  const LocalOps_usersData({required this.users});

  factory LocalOps_usersData.fromJson(Map<String, dynamic> json) =>
      _$LocalOps_usersDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocalOps_usersDataToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_usersData && o.users == users;
  }

  @override
  int get hashCode => users.hashCode;

  @override
  String toString() => "LocalOps_usersData(users: ${this.users})";
}

abstract class $LocalOps_usersDataCopyWith<O> {
  factory $LocalOps_usersDataCopyWith(
          LocalOps_usersData value, O Function(LocalOps_usersData) then) =
      _$LocalOps_usersDataCopyWithImpl<O>;
  O call({List<LocalOps_usersData_users?>? users});
}

class _$LocalOps_usersDataCopyWithImpl<O>
    implements $LocalOps_usersDataCopyWith<O> {
  final LocalOps_usersData _value;
  final O Function(LocalOps_usersData) _then;
  _$LocalOps_usersDataCopyWithImpl(this._value, this._then);

  @override
  O call({Object? users = dimmutable}) {
    return _then(_value.copyWith(
        users: users == dimmutable
            ? _value.users
            : users as List<LocalOps_usersData_users?>?));
  }
}

abstract class _$LocalOps_usersDataCopyWith<O>
    implements $LocalOps_usersDataCopyWith<O> {
  factory _$LocalOps_usersDataCopyWith(
          LocalOps_usersData value, O Function(LocalOps_usersData) then) =
      __$LocalOps_usersDataCopyWithImpl<O>;
  O call({List<LocalOps_usersData_users?>? users});
}

class __$LocalOps_usersDataCopyWithImpl<O>
    extends _$LocalOps_usersDataCopyWithImpl<O>
    implements _$LocalOps_usersDataCopyWith<O> {
  __$LocalOps_usersDataCopyWithImpl(
      LocalOps_usersData _value, O Function(LocalOps_usersData) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_usersData get _value => super._value;

  @override
  O call({Object? users = dimmutable}) {
    return _then(LocalOps_usersData(
        users: users == dimmutable
            ? _value.users
            : users as List<LocalOps_usersData_users?>?));
  }
}

@JsonSerializable()
class LocalOps_usersData_users {
  final String name;

  final List<String?>? tags;

  @JsonKey(
      fromJson: LocalOps_usersData_users_hello.fromJson,
      toJson: LocalOps_usersData_users_hello.toJson)
  final LocalOps_usersData_users_hello? hello;

  @JsonKey(
      fromJson: LocalOps_usersData_users_helloaListDeserializer,
      toJson: LocalOps_usersData_users_helloaListSerializer)
  final List<LocalOps_usersData_users_helloa?>? helloa;

  final LocalOps_usersData_users_address? address;

  @JsonKey(ignore: true)
  _$LocalOps_usersData_usersCopyWith<LocalOps_usersData_users> get copyWith =>
      __$LocalOps_usersData_usersCopyWithImpl<LocalOps_usersData_users>(
          this, IdentityFn);

  const LocalOps_usersData_users(
      {required this.name,
      required this.tags,
      required this.hello,
      required this.helloa,
      required this.address});

  factory LocalOps_usersData_users.fromJson(Map<String, dynamic> json) =>
      _$LocalOps_usersData_usersFromJson(json);

  Map<String, dynamic> toJson() => _$LocalOps_usersData_usersToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_usersData_users &&
        o.name == name &&
        o.tags == tags &&
        o.hello == hello &&
        o.helloa == helloa &&
        o.address == address;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      tags.hashCode ^
      hello.hashCode ^
      helloa.hashCode ^
      address.hashCode;

  @override
  String toString() =>
      "LocalOps_usersData_users(name: ${this.name}, tags: ${this.tags}, hello: ${this.hello}, helloa: ${this.helloa}, address: ${this.address})";
}

abstract class $LocalOps_usersData_usersCopyWith<O> {
  factory $LocalOps_usersData_usersCopyWith(LocalOps_usersData_users value,
          O Function(LocalOps_usersData_users) then) =
      _$LocalOps_usersData_usersCopyWithImpl<O>;
  O call(
      {String name,
      List<String?>? tags,
      LocalOps_usersData_users_hello? hello,
      List<LocalOps_usersData_users_helloa?>? helloa,
      LocalOps_usersData_users_address? address});
}

class _$LocalOps_usersData_usersCopyWithImpl<O>
    implements $LocalOps_usersData_usersCopyWith<O> {
  final LocalOps_usersData_users _value;
  final O Function(LocalOps_usersData_users) _then;
  _$LocalOps_usersData_usersCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? tags = dimmutable,
      Object? hello = dimmutable,
      Object? helloa = dimmutable,
      Object? address = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        tags: tags == dimmutable ? _value.tags : tags as List<String?>?,
        hello: hello == dimmutable
            ? _value.hello
            : hello as LocalOps_usersData_users_hello?,
        helloa: helloa == dimmutable
            ? _value.helloa
            : helloa as List<LocalOps_usersData_users_helloa?>?,
        address: address == dimmutable
            ? _value.address
            : address as LocalOps_usersData_users_address?));
  }
}

abstract class _$LocalOps_usersData_usersCopyWith<O>
    implements $LocalOps_usersData_usersCopyWith<O> {
  factory _$LocalOps_usersData_usersCopyWith(LocalOps_usersData_users value,
          O Function(LocalOps_usersData_users) then) =
      __$LocalOps_usersData_usersCopyWithImpl<O>;
  O call(
      {String name,
      List<String?>? tags,
      LocalOps_usersData_users_hello? hello,
      List<LocalOps_usersData_users_helloa?>? helloa,
      LocalOps_usersData_users_address? address});
}

class __$LocalOps_usersData_usersCopyWithImpl<O>
    extends _$LocalOps_usersData_usersCopyWithImpl<O>
    implements _$LocalOps_usersData_usersCopyWith<O> {
  __$LocalOps_usersData_usersCopyWithImpl(LocalOps_usersData_users _value,
      O Function(LocalOps_usersData_users) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_usersData_users get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? tags = dimmutable,
      Object? hello = dimmutable,
      Object? helloa = dimmutable,
      Object? address = dimmutable}) {
    return _then(LocalOps_usersData_users(
        name: name == dimmutable ? _value.name : name as String,
        tags: tags == dimmutable ? _value.tags : tags as List<String?>?,
        hello: hello == dimmutable
            ? _value.hello
            : hello as LocalOps_usersData_users_hello?,
        helloa: helloa == dimmutable
            ? _value.helloa
            : helloa as List<LocalOps_usersData_users_helloa?>?,
        address: address == dimmutable
            ? _value.address
            : address as LocalOps_usersData_users_address?));
  }
}

class LocalOps_usersData_users_hello {
  final dynamic _value;
  LocalOps_usersData_users_hello.Hello1(
      LocalOps_usersData_users_hello_Hello1 value)
      : _value = value;
  LocalOps_usersData_users_hello.Hello2(
      LocalOps_usersData_users_hello_Hello2 value)
      : _value = value;
  LocalOps_usersData_users_hello_Hello1? get Hello1 =>
      _value is LocalOps_usersData_users_hello_Hello1
          ? _value as LocalOps_usersData_users_hello_Hello1
          : null;
  LocalOps_usersData_users_hello_Hello2? get Hello2 =>
      _value is LocalOps_usersData_users_hello_Hello2
          ? _value as LocalOps_usersData_users_hello_Hello2
          : null;

  static LocalOps_usersData_users_hello? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    if (json["__typename"] == "Hello1") {
      return LocalOps_usersData_users_hello.Hello1(
          LocalOps_usersData_users_hello_Hello1.fromJson(json));
    }
    if (json["__typename"] == "Hello2") {
      return LocalOps_usersData_users_hello.Hello2(
          LocalOps_usersData_users_hello_Hello2.fromJson(json));
    }
    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }

  static Map<String, dynamic>? toJson(LocalOps_usersData_users_hello? value) {
    if (value == null) {
      return null;
    }

    return value._value.toJson() as Map<String, dynamic>;
  }
}

@JsonSerializable()
class LocalOps_usersData_users_hello_Hello1 {
  final String? name;

  final String one;

  @JsonKey(name: "__typename")
  final String d$___typeName;

  @JsonKey(ignore: true)
  _$LocalOps_usersData_users_hello_Hello1CopyWith<
          LocalOps_usersData_users_hello_Hello1>
      get copyWith => __$LocalOps_usersData_users_hello_Hello1CopyWithImpl<
          LocalOps_usersData_users_hello_Hello1>(this, IdentityFn);

  const LocalOps_usersData_users_hello_Hello1(
      {required this.name, required this.one, required this.d$___typeName});

  factory LocalOps_usersData_users_hello_Hello1.fromJson(
          Map<String, dynamic> json) =>
      _$LocalOps_usersData_users_hello_Hello1FromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocalOps_usersData_users_hello_Hello1ToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_usersData_users_hello_Hello1 &&
        o.name == name &&
        o.one == one &&
        o.d$___typeName == d$___typeName;
  }

  @override
  int get hashCode => name.hashCode ^ one.hashCode ^ d$___typeName.hashCode;

  @override
  String toString() =>
      "LocalOps_usersData_users_hello_Hello1(name: ${this.name}, one: ${this.one}, d\$___typeName: ${this.d$___typeName})";
}

abstract class $LocalOps_usersData_users_hello_Hello1CopyWith<O> {
  factory $LocalOps_usersData_users_hello_Hello1CopyWith(
          LocalOps_usersData_users_hello_Hello1 value,
          O Function(LocalOps_usersData_users_hello_Hello1) then) =
      _$LocalOps_usersData_users_hello_Hello1CopyWithImpl<O>;
  O call({String? name, String one, String d$___typeName});
}

class _$LocalOps_usersData_users_hello_Hello1CopyWithImpl<O>
    implements $LocalOps_usersData_users_hello_Hello1CopyWith<O> {
  final LocalOps_usersData_users_hello_Hello1 _value;
  final O Function(LocalOps_usersData_users_hello_Hello1) _then;
  _$LocalOps_usersData_users_hello_Hello1CopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? one = dimmutable,
      Object? d$___typeName = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String?,
        one: one == dimmutable ? _value.one : one as String,
        d$___typeName: d$___typeName == dimmutable
            ? _value.d$___typeName
            : d$___typeName as String));
  }
}

abstract class _$LocalOps_usersData_users_hello_Hello1CopyWith<O>
    implements $LocalOps_usersData_users_hello_Hello1CopyWith<O> {
  factory _$LocalOps_usersData_users_hello_Hello1CopyWith(
          LocalOps_usersData_users_hello_Hello1 value,
          O Function(LocalOps_usersData_users_hello_Hello1) then) =
      __$LocalOps_usersData_users_hello_Hello1CopyWithImpl<O>;
  O call({String? name, String one, String d$___typeName});
}

class __$LocalOps_usersData_users_hello_Hello1CopyWithImpl<O>
    extends _$LocalOps_usersData_users_hello_Hello1CopyWithImpl<O>
    implements _$LocalOps_usersData_users_hello_Hello1CopyWith<O> {
  __$LocalOps_usersData_users_hello_Hello1CopyWithImpl(
      LocalOps_usersData_users_hello_Hello1 _value,
      O Function(LocalOps_usersData_users_hello_Hello1) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_usersData_users_hello_Hello1 get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? one = dimmutable,
      Object? d$___typeName = dimmutable}) {
    return _then(LocalOps_usersData_users_hello_Hello1(
        name: name == dimmutable ? _value.name : name as String?,
        one: one == dimmutable ? _value.one : one as String,
        d$___typeName: d$___typeName == dimmutable
            ? _value.d$___typeName
            : d$___typeName as String));
  }
}

@JsonSerializable()
class LocalOps_usersData_users_hello_Hello2 {
  final String? name;

  final String two;

  @JsonKey(name: "__typename")
  final String d$___typeName;

  @JsonKey(ignore: true)
  _$LocalOps_usersData_users_hello_Hello2CopyWith<
          LocalOps_usersData_users_hello_Hello2>
      get copyWith => __$LocalOps_usersData_users_hello_Hello2CopyWithImpl<
          LocalOps_usersData_users_hello_Hello2>(this, IdentityFn);

  const LocalOps_usersData_users_hello_Hello2(
      {required this.name, required this.two, required this.d$___typeName});

  factory LocalOps_usersData_users_hello_Hello2.fromJson(
          Map<String, dynamic> json) =>
      _$LocalOps_usersData_users_hello_Hello2FromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocalOps_usersData_users_hello_Hello2ToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_usersData_users_hello_Hello2 &&
        o.name == name &&
        o.two == two &&
        o.d$___typeName == d$___typeName;
  }

  @override
  int get hashCode => name.hashCode ^ two.hashCode ^ d$___typeName.hashCode;

  @override
  String toString() =>
      "LocalOps_usersData_users_hello_Hello2(name: ${this.name}, two: ${this.two}, d\$___typeName: ${this.d$___typeName})";
}

abstract class $LocalOps_usersData_users_hello_Hello2CopyWith<O> {
  factory $LocalOps_usersData_users_hello_Hello2CopyWith(
          LocalOps_usersData_users_hello_Hello2 value,
          O Function(LocalOps_usersData_users_hello_Hello2) then) =
      _$LocalOps_usersData_users_hello_Hello2CopyWithImpl<O>;
  O call({String? name, String two, String d$___typeName});
}

class _$LocalOps_usersData_users_hello_Hello2CopyWithImpl<O>
    implements $LocalOps_usersData_users_hello_Hello2CopyWith<O> {
  final LocalOps_usersData_users_hello_Hello2 _value;
  final O Function(LocalOps_usersData_users_hello_Hello2) _then;
  _$LocalOps_usersData_users_hello_Hello2CopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? two = dimmutable,
      Object? d$___typeName = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String?,
        two: two == dimmutable ? _value.two : two as String,
        d$___typeName: d$___typeName == dimmutable
            ? _value.d$___typeName
            : d$___typeName as String));
  }
}

abstract class _$LocalOps_usersData_users_hello_Hello2CopyWith<O>
    implements $LocalOps_usersData_users_hello_Hello2CopyWith<O> {
  factory _$LocalOps_usersData_users_hello_Hello2CopyWith(
          LocalOps_usersData_users_hello_Hello2 value,
          O Function(LocalOps_usersData_users_hello_Hello2) then) =
      __$LocalOps_usersData_users_hello_Hello2CopyWithImpl<O>;
  O call({String? name, String two, String d$___typeName});
}

class __$LocalOps_usersData_users_hello_Hello2CopyWithImpl<O>
    extends _$LocalOps_usersData_users_hello_Hello2CopyWithImpl<O>
    implements _$LocalOps_usersData_users_hello_Hello2CopyWith<O> {
  __$LocalOps_usersData_users_hello_Hello2CopyWithImpl(
      LocalOps_usersData_users_hello_Hello2 _value,
      O Function(LocalOps_usersData_users_hello_Hello2) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_usersData_users_hello_Hello2 get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? two = dimmutable,
      Object? d$___typeName = dimmutable}) {
    return _then(LocalOps_usersData_users_hello_Hello2(
        name: name == dimmutable ? _value.name : name as String?,
        two: two == dimmutable ? _value.two : two as String,
        d$___typeName: d$___typeName == dimmutable
            ? _value.d$___typeName
            : d$___typeName as String));
  }
}

class LocalOps_usersData_users_helloa {
  final dynamic _value;
  LocalOps_usersData_users_helloa.Hello1(
      LocalOps_usersData_users_helloa_Hello1 value)
      : _value = value;
  LocalOps_usersData_users_helloa.Hello2(
      LocalOps_usersData_users_helloa_Hello2 value)
      : _value = value;
  LocalOps_usersData_users_helloa_Hello1? get Hello1 =>
      _value is LocalOps_usersData_users_helloa_Hello1
          ? _value as LocalOps_usersData_users_helloa_Hello1
          : null;
  LocalOps_usersData_users_helloa_Hello2? get Hello2 =>
      _value is LocalOps_usersData_users_helloa_Hello2
          ? _value as LocalOps_usersData_users_helloa_Hello2
          : null;

  static LocalOps_usersData_users_helloa? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    if (json["__typename"] == "Hello1") {
      return LocalOps_usersData_users_helloa.Hello1(
          LocalOps_usersData_users_helloa_Hello1.fromJson(json));
    }
    if (json["__typename"] == "Hello2") {
      return LocalOps_usersData_users_helloa.Hello2(
          LocalOps_usersData_users_helloa_Hello2.fromJson(json));
    }
    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }

  static Map<String, dynamic>? toJson(LocalOps_usersData_users_helloa? value) {
    if (value == null) {
      return null;
    }

    return value._value.toJson() as Map<String, dynamic>;
  }
}

@JsonSerializable()
class LocalOps_usersData_users_helloa_Hello1 {
  final String? name;

  final String one;

  @JsonKey(name: "__typename")
  final String d$___typeName;

  @JsonKey(ignore: true)
  _$LocalOps_usersData_users_helloa_Hello1CopyWith<
          LocalOps_usersData_users_helloa_Hello1>
      get copyWith => __$LocalOps_usersData_users_helloa_Hello1CopyWithImpl<
          LocalOps_usersData_users_helloa_Hello1>(this, IdentityFn);

  const LocalOps_usersData_users_helloa_Hello1(
      {required this.name, required this.one, required this.d$___typeName});

  factory LocalOps_usersData_users_helloa_Hello1.fromJson(
          Map<String, dynamic> json) =>
      _$LocalOps_usersData_users_helloa_Hello1FromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocalOps_usersData_users_helloa_Hello1ToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_usersData_users_helloa_Hello1 &&
        o.name == name &&
        o.one == one &&
        o.d$___typeName == d$___typeName;
  }

  @override
  int get hashCode => name.hashCode ^ one.hashCode ^ d$___typeName.hashCode;

  @override
  String toString() =>
      "LocalOps_usersData_users_helloa_Hello1(name: ${this.name}, one: ${this.one}, d\$___typeName: ${this.d$___typeName})";
}

abstract class $LocalOps_usersData_users_helloa_Hello1CopyWith<O> {
  factory $LocalOps_usersData_users_helloa_Hello1CopyWith(
          LocalOps_usersData_users_helloa_Hello1 value,
          O Function(LocalOps_usersData_users_helloa_Hello1) then) =
      _$LocalOps_usersData_users_helloa_Hello1CopyWithImpl<O>;
  O call({String? name, String one, String d$___typeName});
}

class _$LocalOps_usersData_users_helloa_Hello1CopyWithImpl<O>
    implements $LocalOps_usersData_users_helloa_Hello1CopyWith<O> {
  final LocalOps_usersData_users_helloa_Hello1 _value;
  final O Function(LocalOps_usersData_users_helloa_Hello1) _then;
  _$LocalOps_usersData_users_helloa_Hello1CopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? one = dimmutable,
      Object? d$___typeName = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String?,
        one: one == dimmutable ? _value.one : one as String,
        d$___typeName: d$___typeName == dimmutable
            ? _value.d$___typeName
            : d$___typeName as String));
  }
}

abstract class _$LocalOps_usersData_users_helloa_Hello1CopyWith<O>
    implements $LocalOps_usersData_users_helloa_Hello1CopyWith<O> {
  factory _$LocalOps_usersData_users_helloa_Hello1CopyWith(
          LocalOps_usersData_users_helloa_Hello1 value,
          O Function(LocalOps_usersData_users_helloa_Hello1) then) =
      __$LocalOps_usersData_users_helloa_Hello1CopyWithImpl<O>;
  O call({String? name, String one, String d$___typeName});
}

class __$LocalOps_usersData_users_helloa_Hello1CopyWithImpl<O>
    extends _$LocalOps_usersData_users_helloa_Hello1CopyWithImpl<O>
    implements _$LocalOps_usersData_users_helloa_Hello1CopyWith<O> {
  __$LocalOps_usersData_users_helloa_Hello1CopyWithImpl(
      LocalOps_usersData_users_helloa_Hello1 _value,
      O Function(LocalOps_usersData_users_helloa_Hello1) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_usersData_users_helloa_Hello1 get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? one = dimmutable,
      Object? d$___typeName = dimmutable}) {
    return _then(LocalOps_usersData_users_helloa_Hello1(
        name: name == dimmutable ? _value.name : name as String?,
        one: one == dimmutable ? _value.one : one as String,
        d$___typeName: d$___typeName == dimmutable
            ? _value.d$___typeName
            : d$___typeName as String));
  }
}

@JsonSerializable()
class LocalOps_usersData_users_helloa_Hello2 {
  final String? name;

  final String two;

  @JsonKey(name: "__typename")
  final String d$___typeName;

  @JsonKey(ignore: true)
  _$LocalOps_usersData_users_helloa_Hello2CopyWith<
          LocalOps_usersData_users_helloa_Hello2>
      get copyWith => __$LocalOps_usersData_users_helloa_Hello2CopyWithImpl<
          LocalOps_usersData_users_helloa_Hello2>(this, IdentityFn);

  const LocalOps_usersData_users_helloa_Hello2(
      {required this.name, required this.two, required this.d$___typeName});

  factory LocalOps_usersData_users_helloa_Hello2.fromJson(
          Map<String, dynamic> json) =>
      _$LocalOps_usersData_users_helloa_Hello2FromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocalOps_usersData_users_helloa_Hello2ToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_usersData_users_helloa_Hello2 &&
        o.name == name &&
        o.two == two &&
        o.d$___typeName == d$___typeName;
  }

  @override
  int get hashCode => name.hashCode ^ two.hashCode ^ d$___typeName.hashCode;

  @override
  String toString() =>
      "LocalOps_usersData_users_helloa_Hello2(name: ${this.name}, two: ${this.two}, d\$___typeName: ${this.d$___typeName})";
}

abstract class $LocalOps_usersData_users_helloa_Hello2CopyWith<O> {
  factory $LocalOps_usersData_users_helloa_Hello2CopyWith(
          LocalOps_usersData_users_helloa_Hello2 value,
          O Function(LocalOps_usersData_users_helloa_Hello2) then) =
      _$LocalOps_usersData_users_helloa_Hello2CopyWithImpl<O>;
  O call({String? name, String two, String d$___typeName});
}

class _$LocalOps_usersData_users_helloa_Hello2CopyWithImpl<O>
    implements $LocalOps_usersData_users_helloa_Hello2CopyWith<O> {
  final LocalOps_usersData_users_helloa_Hello2 _value;
  final O Function(LocalOps_usersData_users_helloa_Hello2) _then;
  _$LocalOps_usersData_users_helloa_Hello2CopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? two = dimmutable,
      Object? d$___typeName = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String?,
        two: two == dimmutable ? _value.two : two as String,
        d$___typeName: d$___typeName == dimmutable
            ? _value.d$___typeName
            : d$___typeName as String));
  }
}

abstract class _$LocalOps_usersData_users_helloa_Hello2CopyWith<O>
    implements $LocalOps_usersData_users_helloa_Hello2CopyWith<O> {
  factory _$LocalOps_usersData_users_helloa_Hello2CopyWith(
          LocalOps_usersData_users_helloa_Hello2 value,
          O Function(LocalOps_usersData_users_helloa_Hello2) then) =
      __$LocalOps_usersData_users_helloa_Hello2CopyWithImpl<O>;
  O call({String? name, String two, String d$___typeName});
}

class __$LocalOps_usersData_users_helloa_Hello2CopyWithImpl<O>
    extends _$LocalOps_usersData_users_helloa_Hello2CopyWithImpl<O>
    implements _$LocalOps_usersData_users_helloa_Hello2CopyWith<O> {
  __$LocalOps_usersData_users_helloa_Hello2CopyWithImpl(
      LocalOps_usersData_users_helloa_Hello2 _value,
      O Function(LocalOps_usersData_users_helloa_Hello2) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_usersData_users_helloa_Hello2 get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? two = dimmutable,
      Object? d$___typeName = dimmutable}) {
    return _then(LocalOps_usersData_users_helloa_Hello2(
        name: name == dimmutable ? _value.name : name as String?,
        two: two == dimmutable ? _value.two : two as String,
        d$___typeName: d$___typeName == dimmutable
            ? _value.d$___typeName
            : d$___typeName as String));
  }
}

@JsonSerializable()
class LocalOps_usersData_users_address {
  final String street;

  final String zip;

  final LocalOps_usersData_users_address_country country;

  @JsonKey(ignore: true)
  _$LocalOps_usersData_users_addressCopyWith<LocalOps_usersData_users_address>
      get copyWith => __$LocalOps_usersData_users_addressCopyWithImpl<
          LocalOps_usersData_users_address>(this, IdentityFn);

  const LocalOps_usersData_users_address(
      {required this.street, required this.zip, required this.country});

  factory LocalOps_usersData_users_address.fromJson(
          Map<String, dynamic> json) =>
      _$LocalOps_usersData_users_addressFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocalOps_usersData_users_addressToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_usersData_users_address &&
        o.street == street &&
        o.zip == zip &&
        o.country == country;
  }

  @override
  int get hashCode => street.hashCode ^ zip.hashCode ^ country.hashCode;

  @override
  String toString() =>
      "LocalOps_usersData_users_address(street: ${this.street}, zip: ${this.zip}, country: ${this.country})";
}

abstract class $LocalOps_usersData_users_addressCopyWith<O> {
  factory $LocalOps_usersData_users_addressCopyWith(
          LocalOps_usersData_users_address value,
          O Function(LocalOps_usersData_users_address) then) =
      _$LocalOps_usersData_users_addressCopyWithImpl<O>;
  O call(
      {String street,
      String zip,
      LocalOps_usersData_users_address_country country});
}

class _$LocalOps_usersData_users_addressCopyWithImpl<O>
    implements $LocalOps_usersData_users_addressCopyWith<O> {
  final LocalOps_usersData_users_address _value;
  final O Function(LocalOps_usersData_users_address) _then;
  _$LocalOps_usersData_users_addressCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? street = dimmutable,
      Object? zip = dimmutable,
      Object? country = dimmutable}) {
    return _then(_value.copyWith(
        street: street == dimmutable ? _value.street : street as String,
        zip: zip == dimmutable ? _value.zip : zip as String,
        country: country == dimmutable
            ? _value.country
            : country as LocalOps_usersData_users_address_country));
  }
}

abstract class _$LocalOps_usersData_users_addressCopyWith<O>
    implements $LocalOps_usersData_users_addressCopyWith<O> {
  factory _$LocalOps_usersData_users_addressCopyWith(
          LocalOps_usersData_users_address value,
          O Function(LocalOps_usersData_users_address) then) =
      __$LocalOps_usersData_users_addressCopyWithImpl<O>;
  O call(
      {String street,
      String zip,
      LocalOps_usersData_users_address_country country});
}

class __$LocalOps_usersData_users_addressCopyWithImpl<O>
    extends _$LocalOps_usersData_users_addressCopyWithImpl<O>
    implements _$LocalOps_usersData_users_addressCopyWith<O> {
  __$LocalOps_usersData_users_addressCopyWithImpl(
      LocalOps_usersData_users_address _value,
      O Function(LocalOps_usersData_users_address) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_usersData_users_address get _value => super._value;

  @override
  O call(
      {Object? street = dimmutable,
      Object? zip = dimmutable,
      Object? country = dimmutable}) {
    return _then(LocalOps_usersData_users_address(
        street: street == dimmutable ? _value.street : street as String,
        zip: zip == dimmutable ? _value.zip : zip as String,
        country: country == dimmutable
            ? _value.country
            : country as LocalOps_usersData_users_address_country));
  }
}

@JsonSerializable()
class LocalOps_usersData_users_address_country {
  final String code;

  final String name;

  @JsonKey(ignore: true)
  _$LocalOps_usersData_users_address_countryCopyWith<
          LocalOps_usersData_users_address_country>
      get copyWith => __$LocalOps_usersData_users_address_countryCopyWithImpl<
          LocalOps_usersData_users_address_country>(this, IdentityFn);

  const LocalOps_usersData_users_address_country(
      {required this.code, required this.name});

  factory LocalOps_usersData_users_address_country.fromJson(
          Map<String, dynamic> json) =>
      _$LocalOps_usersData_users_address_countryFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocalOps_usersData_users_address_countryToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LocalOps_usersData_users_address_country &&
        o.code == code &&
        o.name == name;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode;

  @override
  String toString() =>
      "LocalOps_usersData_users_address_country(code: ${this.code}, name: ${this.name})";
}

abstract class $LocalOps_usersData_users_address_countryCopyWith<O> {
  factory $LocalOps_usersData_users_address_countryCopyWith(
          LocalOps_usersData_users_address_country value,
          O Function(LocalOps_usersData_users_address_country) then) =
      _$LocalOps_usersData_users_address_countryCopyWithImpl<O>;
  O call({String code, String name});
}

class _$LocalOps_usersData_users_address_countryCopyWithImpl<O>
    implements $LocalOps_usersData_users_address_countryCopyWith<O> {
  final LocalOps_usersData_users_address_country _value;
  final O Function(LocalOps_usersData_users_address_country) _then;
  _$LocalOps_usersData_users_address_countryCopyWithImpl(
      this._value, this._then);

  @override
  O call({Object? code = dimmutable, Object? name = dimmutable}) {
    return _then(_value.copyWith(
        code: code == dimmutable ? _value.code : code as String,
        name: name == dimmutable ? _value.name : name as String));
  }
}

abstract class _$LocalOps_usersData_users_address_countryCopyWith<O>
    implements $LocalOps_usersData_users_address_countryCopyWith<O> {
  factory _$LocalOps_usersData_users_address_countryCopyWith(
          LocalOps_usersData_users_address_country value,
          O Function(LocalOps_usersData_users_address_country) then) =
      __$LocalOps_usersData_users_address_countryCopyWithImpl<O>;
  O call({String code, String name});
}

class __$LocalOps_usersData_users_address_countryCopyWithImpl<O>
    extends _$LocalOps_usersData_users_address_countryCopyWithImpl<O>
    implements _$LocalOps_usersData_users_address_countryCopyWith<O> {
  __$LocalOps_usersData_users_address_countryCopyWithImpl(
      LocalOps_usersData_users_address_country _value,
      O Function(LocalOps_usersData_users_address_country) _then)
      : super(_value, (v) => _then(v));

  @override
  LocalOps_usersData_users_address_country get _value => super._value;

  @override
  O call({Object? code = dimmutable, Object? name = dimmutable}) {
    return _then(LocalOps_usersData_users_address_country(
        code: code == dimmutable ? _value.code : code as String,
        name: name == dimmutable ? _value.name : name as String));
  }
}

List<Map<String, dynamic>?>? LocalOps_usersData_users_helloaListSerializer(
    List<LocalOps_usersData_users_helloa?>? input) {
  if (input == null) {
    return null;
  }

  return input.map((m) => LocalOps_usersData_users_helloa.toJson(m)).toList();
}

List<LocalOps_usersData_users_helloa?>?
    LocalOps_usersData_users_helloaListDeserializer(Object? input) {
  if (input == null) {
    return null;
  }

  return (input as List<dynamic>)
      .map((dynamic e) =>
          LocalOps_usersData_users_helloa.fromJson(e as Map<String, dynamic>?))
      .toList();
}

GraphqlRequestInput<Null> LocalOps_usersInputDeserializer(dynamic json) {
  return GraphqlRequestInput.fromJson(json as Map<String, dynamic>);
}

Map<String, dynamic> LocalOps_usersDataSerializer(
        int status, LocalOps_usersData resp) =>
    resp.toJson();

LocalOps_usersData LocalOps_usersDataDeserializer(int status, dynamic json) =>
    LocalOps_usersData.fromJson(json as Map<String, dynamic>);

@HttpRequest(
    method: "POST",
    url: "http://localhost:4000/graphql",
    graphqlQuery: GraphqlRequestPart(query: """query LocalOps_users { 
 users  {  
 name

tags

          hello {
                   __typename
              ... on Hello1 {
         name
one
       }
      
       ... on Hello2 {
         name
two
       }
      
     
          }
        
          helloa {
                   __typename
              ... on Hello1 {
         name
one
       }
      
       ... on Hello2 {
         name
two
       }
      
     
          }
        
address {
             street
zip
country {
             code
name
          } 
          }  }

 }""", hash: null, useGetForPersist: false),
    responseType: HttpResponseType.JSON,
    headers: {"Content_Type": "applications/josn"},
    responseSerializer: LocalOps_usersDataSerializer,
    inputSerializer: GraphqlRequestInput.toJson,
    inputDeserializer: LocalOps_usersInputDeserializer,
    responseDeserializer: LocalOps_usersDataDeserializer)
typedef LocalOps_users
    = HttpField<GraphqlRequestInput<Null>, LocalOps_usersData, String>;

@HttpRequest(
    method: "POST",
    url: "http://localhost:4000/graphql",
    graphqlQuery: GraphqlRequestPart(query: """query LocalOps_users { 
 users  {  
 name

tags

          hello {
                   __typename
              ... on Hello1 {
         name
one
       }
      
       ... on Hello2 {
         name
two
       }
      
     
          }
        
          helloa {
                   __typename
              ... on Hello1 {
         name
one
       }
      
       ... on Hello2 {
         name
two
       }
      
     
          }
        
address {
             street
zip
country {
             code
name
          } 
          }  }

 }""", hash: null, useGetForPersist: false),
    responseType: HttpResponseType.JSON,
    headers: {"Content_Type": "applications/josn"},
    responseSerializer: LocalOps_usersDataSerializer,
    inputSerializer: GraphqlRequestInput.toJson,
    inputDeserializer: LocalOps_usersInputDeserializer,
    responseDeserializer: LocalOps_usersDataDeserializer)
typedef LocalOps_usersT<T> = HttpField<GraphqlRequestInput<Null>, T, String>;
