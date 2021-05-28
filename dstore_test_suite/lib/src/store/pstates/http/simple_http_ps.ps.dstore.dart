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

  _$SimpleHttpCopyWith<SimpleHttp> get copyWith =>
      __$SimpleHttpCopyWithImpl<SimpleHttp>(this, IdentityFn);

  SimpleHttp(
      {this.ping = const helloPing(),
      this.json = const helloJson(),
      this.octet = const HelloOctet(),
      this.optFail = const OptimisticFail(),
      this.pinInt = const helloJsonTransform()});

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
          : this.pinInt);

  Map<String, dynamic> toMap() => <String, dynamic>{
        "ping": this.ping,
        "json": this.json,
        "octet": this.octet,
        "optFail": this.optFail,
        "pinInt": this.pinInt
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is SimpleHttp &&
        o.ping == ping &&
        o.json == json &&
        o.octet == octet &&
        o.optFail == optFail &&
        o.pinInt == pinInt;
  }

  @override
  int get hashCode =>
      ping.hashCode ^
      json.hashCode ^
      octet.hashCode ^
      optFail.hashCode ^
      pinInt.hashCode;

  @override
  String toString() =>
      "SimpleHttp(ping: ${this.ping}, json: ${this.json}, octet: ${this.octet}, optFail: ${this.optFail}, pinInt: ${this.pinInt})";
}

abstract class $SimpleHttpCopyWith<O> {
  factory $SimpleHttpCopyWith(SimpleHttp value, O Function(SimpleHttp) then) =
      _$SimpleHttpCopyWithImpl<O>;
  O call(
      {helloPing ping,
      helloJson json,
      HelloOctet octet,
      OptimisticFail optFail,
      helloJsonTransform<int> pinInt});
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
      Object? pinInt = dimmutable}) {
    return _then(_value.copyWith(
        ping: ping == dimmutable ? _value.ping : ping as helloPing,
        json: json == dimmutable ? _value.json : json as helloJson,
        octet: octet == dimmutable ? _value.octet : octet as HelloOctet,
        optFail:
            optFail == dimmutable ? _value.optFail : optFail as OptimisticFail,
        pinInt: pinInt == dimmutable
            ? _value.pinInt
            : pinInt as helloJsonTransform<int>));
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
      helloJsonTransform<int> pinInt});
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
      Object? pinInt = dimmutable}) {
    return _then(SimpleHttp(
        ping: ping == dimmutable ? _value.ping : ping as helloPing,
        json: json == dimmutable ? _value.json : json as helloJson,
        octet: octet == dimmutable ? _value.octet : octet as HelloOctet,
        optFail:
            optFail == dimmutable ? _value.optFail : optFail as OptimisticFail,
        pinInt: pinInt == dimmutable
            ? _value.pinInt
            : pinInt as helloJsonTransform<int>));
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
}

SimpleHttp SimpleHttp_DS() => SimpleHttp(
    ping: helloPing(),
    json: helloJson(),
    octet: HelloOctet(),
    optFail: OptimisticFail(),
    pinInt: helloJsonTransform());

final SimpleHttpMeta = PStateMeta<SimpleHttp>(
    type: _SimpleHttp_FullPath,
    ds: SimpleHttp_DS,
    httpMetaMap: {
      "ping": HttpMeta<Null, Null, Null, String, String, Null>(
          responseSerializer: helloPingResponse_SuccessSerializer,
          responseDeserializer: helloPingResponse_SuccessDeserializer),
      "json": HttpMeta<Null, Null, Null, helloJsonResponse, String, Null>(
          responseSerializer: helloJsonResponse.toJsonStatic,
          responseDeserializer: helloJsonResponse.fromJsonStatic),
      "octet": HttpMeta<Null, Null, Null, List<int>, String, Null>(
          responseSerializer: HelloOctetResponse_SuccessSerializer,
          responseDeserializer: HelloOctetResponse_SuccessDeserializer),
      "optFail": HttpMeta<Null, Null, Null, String, String, Null>(
          responseSerializer: OptimisticFailResponse_SuccessSerializer,
          responseDeserializer: OptimisticFailResponse_SuccessDeserializer),
      "pinInt": HttpMeta<Null, Null, Null, helloJsonResponse, String, int>(
          responseSerializer: helloJsonResponse.toJsonStatic,
          transformer: pingTransform,
          responseDeserializer: helloJsonResponse.fromJsonStatic)
    });
