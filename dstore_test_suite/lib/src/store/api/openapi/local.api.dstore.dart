// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local.dart';

// **************************************************************************
// OpenApiGenerator
// **************************************************************************

String helloPingResponse_SuccessSerializer(int status, String input) => input;

String helloPingResponse_SuccessDeserializer(int status, dynamic input) =>
    input.toString();

String helloPingResponse_ErrorSerializer(int status, String input) => input;

String helloPingResponse_ErrorDeserializer(int status, dynamic input) =>
    input.toString();

@JsonSerializable()
class helloJsonResponse {
  final String name;

  final int count;

  @JsonKey(ignore: true)
  _$helloJsonResponseCopyWith<helloJsonResponse> get copyWith =>
      __$helloJsonResponseCopyWithImpl<helloJsonResponse>(this, IdentityFn);

  const helloJsonResponse({required this.name, required this.count});

  factory helloJsonResponse.fromJson(Map<String, dynamic> json) =>
      _$helloJsonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$helloJsonResponseToJson(this);

  static helloJsonResponse fromJsonStatic(int status, dynamic value) =>
      _$helloJsonResponseFromJson(value as Map<String, dynamic>);

  static dynamic toJsonStatic(int status, helloJsonResponse input) =>
      input.toJson();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is helloJsonResponse && o.name == name && o.count == count;
  }

  @override
  int get hashCode => name.hashCode ^ count.hashCode;

  @override
  String toString() =>
      "helloJsonResponse(name: ${this.name}, count: ${this.count})";
}

abstract class $helloJsonResponseCopyWith<O> {
  factory $helloJsonResponseCopyWith(
          helloJsonResponse value, O Function(helloJsonResponse) then) =
      _$helloJsonResponseCopyWithImpl<O>;
  O call({String name, int count});
}

class _$helloJsonResponseCopyWithImpl<O>
    implements $helloJsonResponseCopyWith<O> {
  final helloJsonResponse _value;
  final O Function(helloJsonResponse) _then;
  _$helloJsonResponseCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable, Object? count = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        count: count == dimmutable ? _value.count : count as int));
  }
}

abstract class _$helloJsonResponseCopyWith<O>
    implements $helloJsonResponseCopyWith<O> {
  factory _$helloJsonResponseCopyWith(
          helloJsonResponse value, O Function(helloJsonResponse) then) =
      __$helloJsonResponseCopyWithImpl<O>;
  O call({String name, int count});
}

class __$helloJsonResponseCopyWithImpl<O>
    extends _$helloJsonResponseCopyWithImpl<O>
    implements _$helloJsonResponseCopyWith<O> {
  __$helloJsonResponseCopyWithImpl(
      helloJsonResponse _value, O Function(helloJsonResponse) _then)
      : super(_value, (v) => _then(v));

  @override
  helloJsonResponse get _value => super._value;

  @override
  O call({Object? name = dimmutable, Object? count = dimmutable}) {
    return _then(helloJsonResponse(
        name: name == dimmutable ? _value.name : name as String,
        count: count == dimmutable ? _value.count : count as int));
  }
}

String helloJsonResponse_ErrorSerializer(int status, String input) => input;

String helloJsonResponse_ErrorDeserializer(int status, dynamic input) =>
    input.toString();

List<int> HelloOctetResponse_SuccessSerializer(int status, List<int> input) =>
    input;

List<int> HelloOctetResponse_SuccessDeserializer(int status, dynamic input) =>
    input as List<int>;

String HelloOctetResponse_ErrorSerializer(int status, String input) => input;

String HelloOctetResponse_ErrorDeserializer(int status, dynamic input) =>
    input.toString();

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/",
    responseType: HttpResponseType.STRING,
    responseSerializer: helloPingResponse_SuccessSerializer,
    responseDeserializer: helloPingResponse_SuccessDeserializer,
    errorDeserializer: helloPingResponse_ErrorDeserializer)
typedef helloPing = HttpField<Null, String, String>;

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/json",
    responseType: HttpResponseType.JSON,
    responseSerializer: helloJsonResponse.toJsonStatic,
    responseDeserializer: helloJsonResponse.fromJsonStatic,
    errorDeserializer: helloJsonResponse_ErrorDeserializer)
typedef helloJson = HttpField<Null, helloJsonResponse, String>;

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/octet",
    responseType: HttpResponseType.BYTES,
    responseSerializer: HelloOctetResponse_SuccessSerializer,
    responseDeserializer: HelloOctetResponse_SuccessDeserializer,
    errorDeserializer: HelloOctetResponse_ErrorDeserializer)
typedef HelloOctet = HttpField<Null, List<int>, String>;
