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

String OptimisticFailResponse_SuccessSerializer(int status, String input) =>
    input;

String OptimisticFailResponse_SuccessDeserializer(int status, dynamic input) =>
    input.toString();

String OptimisticFailResponse_ErrorSerializer(int status, String input) =>
    input;

String OptimisticFailResponse_ErrorDeserializer(int status, dynamic input) =>
    input.toString();

@JsonSerializable()
class PaginationPathParams {
  final int page;

  @JsonKey(ignore: true)
  _$PaginationPathParamsCopyWith<PaginationPathParams> get copyWith =>
      __$PaginationPathParamsCopyWithImpl<PaginationPathParams>(
          this, IdentityFn);

  const PaginationPathParams({required this.page});

  factory PaginationPathParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationPathParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationPathParamsToJson(this);

  static PaginationPathParams fromJsonStatic(dynamic value) =>
      _$PaginationPathParamsFromJson(value as Map<String, dynamic>);

  static Map<String, dynamic> toJsonStatic(dynamic input) =>
      (input as PaginationPathParams).toJson();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PaginationPathParams && o.page == page;
  }

  @override
  int get hashCode => page.hashCode;

  @override
  String toString() => "PaginationPathParams(page: ${this.page})";
}

abstract class $PaginationPathParamsCopyWith<O> {
  factory $PaginationPathParamsCopyWith(
          PaginationPathParams value, O Function(PaginationPathParams) then) =
      _$PaginationPathParamsCopyWithImpl<O>;
  O call({int page});
}

class _$PaginationPathParamsCopyWithImpl<O>
    implements $PaginationPathParamsCopyWith<O> {
  final PaginationPathParams _value;
  final O Function(PaginationPathParams) _then;
  _$PaginationPathParamsCopyWithImpl(this._value, this._then);

  @override
  O call({Object? page = dimmutable}) {
    return _then(
        _value.copyWith(page: page == dimmutable ? _value.page : page as int));
  }
}

abstract class _$PaginationPathParamsCopyWith<O>
    implements $PaginationPathParamsCopyWith<O> {
  factory _$PaginationPathParamsCopyWith(
          PaginationPathParams value, O Function(PaginationPathParams) then) =
      __$PaginationPathParamsCopyWithImpl<O>;
  O call({int page});
}

class __$PaginationPathParamsCopyWithImpl<O>
    extends _$PaginationPathParamsCopyWithImpl<O>
    implements _$PaginationPathParamsCopyWith<O> {
  __$PaginationPathParamsCopyWithImpl(
      PaginationPathParams _value, O Function(PaginationPathParams) _then)
      : super(_value, (v) => _then(v));

  @override
  PaginationPathParams get _value => super._value;

  @override
  O call({Object? page = dimmutable}) {
    return _then(PaginationPathParams(
        page: page == dimmutable ? _value.page : page as int));
  }
}

@JsonSerializable()
class PaginationResponse {
  final List<String> list;

  final int? nextPage;

  @JsonKey(ignore: true)
  _$PaginationResponseCopyWith<PaginationResponse> get copyWith =>
      __$PaginationResponseCopyWithImpl<PaginationResponse>(this, IdentityFn);

  const PaginationResponse({required this.list, this.nextPage});

  factory PaginationResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationResponseToJson(this);

  static PaginationResponse fromJsonStatic(int status, dynamic value) =>
      _$PaginationResponseFromJson(value as Map<String, dynamic>);

  static dynamic toJsonStatic(int status, PaginationResponse input) =>
      input.toJson();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PaginationResponse &&
        ListEquality<dynamic>().equals(list, o.list) &&
        o.nextPage == nextPage;
  }

  @override
  int get hashCode => list.hashCode ^ nextPage.hashCode;

  @override
  String toString() =>
      "PaginationResponse(list: ${this.list}, nextPage: ${this.nextPage})";
}

abstract class $PaginationResponseCopyWith<O> {
  factory $PaginationResponseCopyWith(
          PaginationResponse value, O Function(PaginationResponse) then) =
      _$PaginationResponseCopyWithImpl<O>;
  O call({List<String> list, int? nextPage});
}

class _$PaginationResponseCopyWithImpl<O>
    implements $PaginationResponseCopyWith<O> {
  final PaginationResponse _value;
  final O Function(PaginationResponse) _then;
  _$PaginationResponseCopyWithImpl(this._value, this._then);

  @override
  O call({Object? list = dimmutable, Object? nextPage = dimmutable}) {
    return _then(_value.copyWith(
        list: list == dimmutable ? _value.list : list as List<String>,
        nextPage: nextPage == dimmutable ? _value.nextPage : nextPage as int?));
  }
}

abstract class _$PaginationResponseCopyWith<O>
    implements $PaginationResponseCopyWith<O> {
  factory _$PaginationResponseCopyWith(
          PaginationResponse value, O Function(PaginationResponse) then) =
      __$PaginationResponseCopyWithImpl<O>;
  O call({List<String> list, int? nextPage});
}

class __$PaginationResponseCopyWithImpl<O>
    extends _$PaginationResponseCopyWithImpl<O>
    implements _$PaginationResponseCopyWith<O> {
  __$PaginationResponseCopyWithImpl(
      PaginationResponse _value, O Function(PaginationResponse) _then)
      : super(_value, (v) => _then(v));

  @override
  PaginationResponse get _value => super._value;

  @override
  O call({Object? list = dimmutable, Object? nextPage = dimmutable}) {
    return _then(PaginationResponse(
        list: list == dimmutable ? _value.list : list as List<String>,
        nextPage: nextPage == dimmutable ? _value.nextPage : nextPage as int?));
  }
}

String PaginationResponse_ErrorSerializer(int status, String input) => input;

String PaginationResponse_ErrorDeserializer(int status, dynamic input) =>
    input.toString();

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/",
    responseType: HttpResponseType.STRING,
    responseSerializer: helloPingResponse_SuccessSerializer,
    responseDeserializer: helloPingResponse_SuccessDeserializer,
    errorDeserializer: helloPingResponse_ErrorDeserializer)
typedef helloPing = HttpField<Null, String, String>;

// use this when you want to transform original http response type(like when you want to store only part of response or paginations etc)
@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/",
    responseType: HttpResponseType.STRING,
    responseSerializer: helloPingResponse_SuccessSerializer,
    responseDeserializer: helloPingResponse_SuccessDeserializer,
    errorDeserializer: helloPingResponse_ErrorDeserializer,
    originalResponseType: 'String')
typedef helloPingTransform<T> = HttpField<Null, T, String>;

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/json",
    responseType: HttpResponseType.JSON,
    responseSerializer: helloJsonResponse.toJsonStatic,
    responseDeserializer: helloJsonResponse.fromJsonStatic,
    errorDeserializer: helloJsonResponse_ErrorDeserializer)
typedef helloJson = HttpField<Null, helloJsonResponse, String>;

// use this when you want to transform original http response type(like when you want to store only part of response or paginations etc)
@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/json",
    responseType: HttpResponseType.JSON,
    responseSerializer: helloJsonResponse.toJsonStatic,
    responseDeserializer: helloJsonResponse.fromJsonStatic,
    errorDeserializer: helloJsonResponse_ErrorDeserializer,
    originalResponseType: 'helloJsonResponse')
typedef helloJsonTransform<T> = HttpField<Null, T, String>;

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/octet",
    responseType: HttpResponseType.BYTES,
    responseSerializer: HelloOctetResponse_SuccessSerializer,
    responseDeserializer: HelloOctetResponse_SuccessDeserializer,
    errorDeserializer: HelloOctetResponse_ErrorDeserializer)
typedef HelloOctet = HttpField<Null, List<int>, String>;

// use this when you want to transform original http response type(like when you want to store only part of response or paginations etc)
@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/octet",
    responseType: HttpResponseType.BYTES,
    responseSerializer: HelloOctetResponse_SuccessSerializer,
    responseDeserializer: HelloOctetResponse_SuccessDeserializer,
    errorDeserializer: HelloOctetResponse_ErrorDeserializer,
    originalResponseType: 'List<int>')
typedef HelloOctetTransform<T> = HttpField<Null, T, String>;

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/optimistic-fail",
    responseType: HttpResponseType.STRING,
    responseSerializer: OptimisticFailResponse_SuccessSerializer,
    responseDeserializer: OptimisticFailResponse_SuccessDeserializer,
    errorDeserializer: OptimisticFailResponse_ErrorDeserializer)
typedef OptimisticFail = HttpField<Null, String, String>;

// use this when you want to transform original http response type(like when you want to store only part of response or paginations etc)
@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/optimistic-fail",
    responseType: HttpResponseType.STRING,
    responseSerializer: OptimisticFailResponse_SuccessSerializer,
    responseDeserializer: OptimisticFailResponse_SuccessDeserializer,
    errorDeserializer: OptimisticFailResponse_ErrorDeserializer,
    originalResponseType: 'String')
typedef OptimisticFailTransform<T> = HttpField<Null, T, String>;

@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/pagination/{page}",
    responseType: HttpResponseType.JSON,
    responseSerializer: PaginationResponse.toJsonStatic,
    responseDeserializer: PaginationResponse.fromJsonStatic,
    errorDeserializer: PaginationResponse_ErrorDeserializer,
    pathParamsType: "PaginationPathParams")
typedef Pagination = HttpField<Null, PaginationResponse, String>;

// use this when you want to transform original http response type(like when you want to store only part of response or paginations etc)
@HttpRequest(
    method: "GET",
    url: "http://localhost:8080/pagination/{page}",
    responseType: HttpResponseType.JSON,
    responseSerializer: PaginationResponse.toJsonStatic,
    responseDeserializer: PaginationResponse.fromJsonStatic,
    errorDeserializer: PaginationResponse_ErrorDeserializer,
    pathParamsType: "PaginationPathParams",
    originalResponseType: 'PaginationResponse')
typedef PaginationTransform<T> = HttpField<Null, T, String>;
