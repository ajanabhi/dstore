// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_http_ps.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class SimpleHttp extends PStateModel<SimpleHttp> {
  final helloPing ping;

  final helloJson json;

  final HelloOctet octet;

  final OptimisticFail optFail;

  @HttpRequestExtension(transformer: pingTransform)
  final helloJsonTransform<int> pinInt;

  @HttpRequestExtension(
      transformer: paginationTransformer, persitDataBetweenFetches: true)
  final Pagination pagination;

  _$SimpleHttpCopyWith<SimpleHttp> get copyWith =>
      __$SimpleHttpCopyWithImpl<SimpleHttp>(this, IdentityFn);

  SimpleHttp(
      {this.ping = const helloPing(),
      this.json = const helloJson(),
      this.octet = const HelloOctet(),
      this.optFail = const OptimisticFail(),
      this.pinInt = const helloJsonTransform(),
      this.pagination = const Pagination()});

  @override
  SimpleHttp copyWithMap(Map<String, dynamic> map) => SimpleHttp(
      ping: map.containsKey("ping") ? map["ping"] as helloPing : this.ping,
      json: map.containsKey("json") ? map["json"] as helloJson : this.json,
      octet: map.containsKey("octet") ? map["octet"] as HelloOctet : this.octet,
      optFail: map.containsKey("optFail")
          ? map["optFail"] as OptimisticFail
          : this.optFail,
      pinInt: map.containsKey("pinInt")
          ? map["pinInt"] as helloJsonTransform<int>
          : this.pinInt,
      pagination: map.containsKey("pagination")
          ? map["pagination"] as Pagination
          : this.pagination);

  Map<String, dynamic> toMap() => <String, dynamic>{
        "ping": this.ping,
        "json": this.json,
        "octet": this.octet,
        "optFail": this.optFail,
        "pinInt": this.pinInt,
        "pagination": this.pagination
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is SimpleHttp &&
        o.ping == ping &&
        o.json == json &&
        o.octet == octet &&
        o.optFail == optFail &&
        o.pinInt == pinInt &&
        o.pagination == pagination;
  }

  @override
  int get hashCode =>
      ping.hashCode ^
      json.hashCode ^
      octet.hashCode ^
      optFail.hashCode ^
      pinInt.hashCode ^
      pagination.hashCode;

  @override
  String toString() =>
      "SimpleHttp(ping: ${this.ping}, json: ${this.json}, octet: ${this.octet}, optFail: ${this.optFail}, pinInt: ${this.pinInt}, pagination: ${this.pagination})";
}

abstract class $SimpleHttpCopyWith<O> {
  factory $SimpleHttpCopyWith(SimpleHttp value, O Function(SimpleHttp) then) =
      _$SimpleHttpCopyWithImpl<O>;
  O call(
      {helloPing ping,
      helloJson json,
      HelloOctet octet,
      OptimisticFail optFail,
      helloJsonTransform<int> pinInt,
      Pagination pagination});
}

class _$SimpleHttpCopyWithImpl<O> implements $SimpleHttpCopyWith<O> {
  final SimpleHttp _value;
  final O Function(SimpleHttp) _then;
  _$SimpleHttpCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? ping = dimmutable,
      Object? json = dimmutable,
      Object? octet = dimmutable,
      Object? optFail = dimmutable,
      Object? pinInt = dimmutable,
      Object? pagination = dimmutable}) {
    return _then(_value.copyWith(
        ping: ping == dimmutable ? _value.ping : ping as helloPing,
        json: json == dimmutable ? _value.json : json as helloJson,
        octet: octet == dimmutable ? _value.octet : octet as HelloOctet,
        optFail:
            optFail == dimmutable ? _value.optFail : optFail as OptimisticFail,
        pinInt: pinInt == dimmutable
            ? _value.pinInt
            : pinInt as helloJsonTransform<int>,
        pagination: pagination == dimmutable
            ? _value.pagination
            : pagination as Pagination));
  }
}

abstract class _$SimpleHttpCopyWith<O> implements $SimpleHttpCopyWith<O> {
  factory _$SimpleHttpCopyWith(SimpleHttp value, O Function(SimpleHttp) then) =
      __$SimpleHttpCopyWithImpl<O>;
  O call(
      {helloPing ping,
      helloJson json,
      HelloOctet octet,
      OptimisticFail optFail,
      helloJsonTransform<int> pinInt,
      Pagination pagination});
}

class __$SimpleHttpCopyWithImpl<O> extends _$SimpleHttpCopyWithImpl<O>
    implements _$SimpleHttpCopyWith<O> {
  __$SimpleHttpCopyWithImpl(SimpleHttp _value, O Function(SimpleHttp) _then)
      : super(_value, (v) => _then(v));

  @override
  SimpleHttp get _value => super._value;

  @override
  O call(
      {Object? ping = dimmutable,
      Object? json = dimmutable,
      Object? octet = dimmutable,
      Object? optFail = dimmutable,
      Object? pinInt = dimmutable,
      Object? pagination = dimmutable}) {
    return _then(SimpleHttp(
        ping: ping == dimmutable ? _value.ping : ping as helloPing,
        json: json == dimmutable ? _value.json : json as helloJson,
        octet: octet == dimmutable ? _value.octet : octet as HelloOctet,
        optFail:
            optFail == dimmutable ? _value.optFail : optFail as OptimisticFail,
        pinInt: pinInt == dimmutable
            ? _value.pinInt
            : pinInt as helloJsonTransform<int>,
        pagination: pagination == dimmutable
            ? _value.pagination
            : pagination as Pagination));
  }
}

const _SimpleHttp_FullPath = "/store/pstates/http/simple_http_ps/SimpleHttp";

abstract class SimpleHttpActions {
  static Action<HttpField<Null, String, String>> ping(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      String? optimisticResponse,
      HttpField<Null, String, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, String, String>>(
        name: "ping",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, String, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/",
            method: "GET",
            responseType: HttpResponseType.STRING,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, String, String>> pingMock(
      HttpField<Null, String, String> mock) {
    return Action<HttpField<Null, String, String>>(
        name: "ping", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, helloJsonResponse, String>> json(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      helloJsonResponse? optimisticResponse,
      HttpField<Null, helloJsonResponse, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, helloJsonResponse, String>>(
        name: "json",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, helloJsonResponse, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/json",
            method: "GET",
            responseType: HttpResponseType.JSON,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, helloJsonResponse, String>> jsonMock(
      HttpField<Null, helloJsonResponse, String> mock) {
    return Action<HttpField<Null, helloJsonResponse, String>>(
        name: "json", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, List<int>, String>> octet(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      List<int>? optimisticResponse,
      HttpField<Null, List<int>, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, List<int>, String>>(
        name: "octet",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, List<int>, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/octet",
            method: "GET",
            responseType: HttpResponseType.BYTES,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, List<int>, String>> octetMock(
      HttpField<Null, List<int>, String> mock) {
    return Action<HttpField<Null, List<int>, String>>(
        name: "octet", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, String, String>> optFail(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      String? optimisticResponse,
      HttpField<Null, String, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, String, String>>(
        name: "optFail",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, String, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/optimistic-fail",
            method: "GET",
            responseType: HttpResponseType.STRING,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, String, String>> optFailMock(
      HttpField<Null, String, String> mock) {
    return Action<HttpField<Null, String, String>>(
        name: "optFail", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, int, String>> pinInt(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      helloJsonResponse? optimisticResponse,
      HttpField<Null, int, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, int, String>>(
        name: "pinInt",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, helloJsonResponse, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/json",
            method: "GET",
            responseType: HttpResponseType.JSON,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, int, String>> pinIntMock(
      HttpField<Null, int, String> mock) {
    return Action<HttpField<Null, int, String>>(
        name: "pinInt", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, PaginationResponse, String>> pagination(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      PaginationResponse? optimisticResponse,
      required PaginationPathParams pathParams,
      HttpField<Null, PaginationResponse, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, PaginationResponse, String>>(
        name: "pagination",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<PaginationPathParams, Null, Null, PaginationResponse,
                String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/pagination/{page}",
            method: "GET",
            responseType: HttpResponseType.JSON,
            pathParams: pathParams,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, PaginationResponse, String>> paginationMock(
      HttpField<Null, PaginationResponse, String> mock) {
    return Action<HttpField<Null, PaginationResponse, String>>(
        name: "pagination", type: _SimpleHttp_FullPath, mock: mock);
  }
}

SimpleHttp SimpleHttp_DS() => SimpleHttp(
    ping: helloPing(),
    json: helloJson(),
    octet: HelloOctet(),
    optFail: OptimisticFail(),
    pinInt: helloJsonTransform(),
    pagination: Pagination());

final SimpleHttpMeta = PStateMeta<
    SimpleHttp>(type: _SimpleHttp_FullPath, ds: SimpleHttp_DS, httpMetaMap: {
  "ping": HttpMeta<Null, Null, Null, String, String, String>(
      responseSerializer: helloPingResponse_SuccessSerializer,
      responseDeserializer: helloPingResponse_SuccessDeserializer),
  "json":
      HttpMeta<Null, Null, Null, helloJsonResponse, String, helloJsonResponse>(
          responseSerializer: helloJsonResponse.toJsonStatic,
          responseDeserializer: helloJsonResponse.fromJsonStatic),
  "octet": HttpMeta<Null, Null, Null, List<int>, String, List<int>>(
      responseSerializer: HelloOctetResponse_SuccessSerializer,
      responseDeserializer: HelloOctetResponse_SuccessDeserializer),
  "optFail": HttpMeta<Null, Null, Null, String, String, String>(
      responseSerializer: OptimisticFailResponse_SuccessSerializer,
      responseDeserializer: OptimisticFailResponse_SuccessDeserializer),
  "pinInt": HttpMeta<Null, Null, Null, helloJsonResponse, String, int>(
      responseSerializer: helloJsonResponse.toJsonStatic,
      transformer: pingTransform,
      responseDeserializer: helloJsonResponse.fromJsonStatic),
  "pagination": HttpMeta<PaginationPathParams, Null, Null, PaginationResponse,
          String, PaginationResponse>(
      pathParamsSerializer: PaginationPathParams.toJsonStatic,
      pathParamsDeserializer: PaginationPathParams.fromJsonStatic,
      responseSerializer: PaginationResponse.toJsonStatic,
      persitDataBetweenFetches: true,
      transformer: paginationTransformer,
      responseDeserializer: PaginationResponse.fromJsonStatic)
});
