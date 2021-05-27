// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_http_ps.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class SimpleHttp extends PStateModel<SimpleHttp> {
  final helloPing ping;

  _$SimpleHttpCopyWith<SimpleHttp> get copyWith =>
      __$SimpleHttpCopyWithImpl<SimpleHttp>(this, IdentityFn);

  SimpleHttp({this.ping = const helloPing()});

  @override
  SimpleHttp copyWithMap(Map<String, dynamic> map) => SimpleHttp(
      ping: map.containsKey("ping") ? map["ping"] as helloPing : this.ping);

  Map<String, dynamic> toMap() => <String, dynamic>{"ping": this.ping};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is SimpleHttp && o.ping == ping;
  }

  @override
  int get hashCode => ping.hashCode;

  @override
  String toString() => "SimpleHttp(ping: ${this.ping})";
}

abstract class $SimpleHttpCopyWith<O> {
  factory $SimpleHttpCopyWith(SimpleHttp value, O Function(SimpleHttp) then) =
      _$SimpleHttpCopyWithImpl<O>;
  O call({helloPing ping});
}

class _$SimpleHttpCopyWithImpl<O> implements $SimpleHttpCopyWith<O> {
  final SimpleHttp _value;
  final O Function(SimpleHttp) _then;
  _$SimpleHttpCopyWithImpl(this._value, this._then);

  @override
  O call({Object? ping = dimmutable}) {
    return _then(_value.copyWith(
        ping: ping == dimmutable ? _value.ping : ping as helloPing));
  }
}

abstract class _$SimpleHttpCopyWith<O> implements $SimpleHttpCopyWith<O> {
  factory _$SimpleHttpCopyWith(SimpleHttp value, O Function(SimpleHttp) then) =
      __$SimpleHttpCopyWithImpl<O>;
  O call({helloPing ping});
}

class __$SimpleHttpCopyWithImpl<O> extends _$SimpleHttpCopyWithImpl<O>
    implements _$SimpleHttpCopyWith<O> {
  __$SimpleHttpCopyWithImpl(SimpleHttp _value, O Function(SimpleHttp) _then)
      : super(_value, (v) => _then(v));

  @override
  SimpleHttp get _value => super._value;

  @override
  O call({Object? ping = dimmutable}) {
    return _then(
        SimpleHttp(ping: ping == dimmutable ? _value.ping : ping as helloPing));
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
}

SimpleHttp SimpleHttp_DS() => SimpleHttp(ping: helloPing());

final SimpleHttpMeta = PStateMeta<SimpleHttp>(
    type: _SimpleHttp_FullPath,
    ds: SimpleHttp_DS,
    httpMetaMap: {
      "ping": HttpMeta<Null, Null, Null, String, String, dynamic>(
          responseSerializer: helloPingResponse_SuccessSerializer,
          responseDeserializer: helloPingResponse_SuccessDeserializer)
    });
