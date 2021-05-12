// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'http.dart';

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$Hello {
  String get name;

  $HelloCopyWith<Hello> get copyWith;
}

class _Hello implements Hello {
  @override
  final String name;

  _$HelloCopyWith<Hello> get copyWith =>
      __$HelloCopyWithImpl<Hello>(this, IdentityFn);

  const _Hello({required this.name});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _Hello && o.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "Hello(name: ${this.name})";
}

abstract class $HelloCopyWith<O> {
  factory $HelloCopyWith(Hello value, O Function(Hello) then) =
      _$HelloCopyWithImpl<O>;
  O call({String name});
}

class _$HelloCopyWithImpl<O> implements $HelloCopyWith<O> {
  final Hello _value;
  final O Function(Hello) _then;
  _$HelloCopyWithImpl(this._value, this._then);

  @override
  O call({Object? name = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String));
  }
}

abstract class _$HelloCopyWith<O> implements $HelloCopyWith<O> {
  factory _$HelloCopyWith(Hello value, O Function(Hello) then) =
      __$HelloCopyWithImpl<O>;
  O call({String name});
}

class __$HelloCopyWithImpl<O> extends _$HelloCopyWithImpl<O>
    implements _$HelloCopyWith<O> {
  __$HelloCopyWithImpl(Hello _value, O Function(Hello) _then)
      : super(_value, (v) => _then(v));

  @override
  Hello get _value => super._value;

  @override
  O call({Object? name = dimmutable}) {
    return _then(
        Hello(name: name == dimmutable ? _value.name : name as String));
  }
}

mixin _$HttpMeta<I, R, E, T> {
  R Function(int, dynamic) get responseDeserializer;
  dynamic Function(int, R)? get responseSerializer;
  HttpField<dynamic, dynamic, dynamic, dynamic> Function(
      HttpField<dynamic, dynamic, dynamic, dynamic>,
      HttpField<dynamic, dynamic, dynamic, dynamic>)? get transformer;
  dynamic Function(I)? get inputSerializer;
  Future<dynamic> Function(I)? get inputStorageSerializer;
  I Function(dynamic)? get inputDeserializer;
  E Function(int, dynamic)? get errorDeserializer;

  $HttpMetaCopyWith<I, R, E, T, HttpMeta<I, R, E, T>> get copyWith;
}

class _HttpMeta<I, R, E, T> implements HttpMeta<I, R, E, T> {
  @override
  final R Function(int, dynamic) responseDeserializer;

  @override
  final dynamic Function(int, R)? responseSerializer;

  @override
  final HttpField<dynamic, dynamic, dynamic, dynamic> Function(
      HttpField<dynamic, dynamic, dynamic, dynamic>,
      HttpField<dynamic, dynamic, dynamic, dynamic>)? transformer;

  @override
  final dynamic Function(I)? inputSerializer;

  @override
  final Future<dynamic> Function(I)? inputStorageSerializer;

  @override
  final I Function(dynamic)? inputDeserializer;

  @override
  final E Function(int, dynamic)? errorDeserializer;

  _$HttpMetaCopyWith<I, R, E, T, HttpMeta<I, R, E, T>> get copyWith =>
      __$HttpMetaCopyWithImpl<I, R, E, T, HttpMeta<I, R, E, T>>(
          this, IdentityFn);

  const _HttpMeta(
      {required this.responseDeserializer,
      this.responseSerializer,
      this.transformer,
      this.inputSerializer,
      this.inputStorageSerializer,
      this.inputDeserializer,
      this.errorDeserializer});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _HttpMeta &&
        o.responseDeserializer == responseDeserializer &&
        o.responseSerializer == responseSerializer &&
        o.transformer == transformer &&
        o.inputSerializer == inputSerializer &&
        o.inputStorageSerializer == inputStorageSerializer &&
        o.inputDeserializer == inputDeserializer &&
        o.errorDeserializer == errorDeserializer;
  }

  @override
  int get hashCode =>
      responseDeserializer.hashCode ^
      responseSerializer.hashCode ^
      transformer.hashCode ^
      inputSerializer.hashCode ^
      inputStorageSerializer.hashCode ^
      inputDeserializer.hashCode ^
      errorDeserializer.hashCode;

  @override
  String toString() =>
      "HttpMeta(responseDeserializer: ${this.responseDeserializer}, responseSerializer: ${this.responseSerializer}, transformer: ${this.transformer}, inputSerializer: ${this.inputSerializer}, inputStorageSerializer: ${this.inputStorageSerializer}, inputDeserializer: ${this.inputDeserializer}, errorDeserializer: ${this.errorDeserializer})";
}

abstract class $HttpMetaCopyWith<I, R, E, T, O> {
  factory $HttpMetaCopyWith(
          HttpMeta<I, R, E, T> value, O Function(HttpMeta<I, R, E, T>) then) =
      _$HttpMetaCopyWithImpl<I, R, E, T, O>;
  O call(
      {R Function(int, dynamic) responseDeserializer,
      dynamic Function(int, R)? responseSerializer,
      HttpField<dynamic, dynamic, dynamic, dynamic> Function(
              HttpField<dynamic, dynamic, dynamic, dynamic>,
              HttpField<dynamic, dynamic, dynamic, dynamic>)?
          transformer,
      dynamic Function(I)? inputSerializer,
      Future<dynamic> Function(I)? inputStorageSerializer,
      I Function(dynamic)? inputDeserializer,
      E Function(int, dynamic)? errorDeserializer});
}

class _$HttpMetaCopyWithImpl<I, R, E, T, O>
    implements $HttpMetaCopyWith<I, R, E, T, O> {
  final HttpMeta<I, R, E, T> _value;
  final O Function(HttpMeta<I, R, E, T>) _then;
  _$HttpMetaCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? responseDeserializer = dimmutable,
      Object? responseSerializer = dimmutable,
      Object? transformer = dimmutable,
      Object? inputSerializer = dimmutable,
      Object? inputStorageSerializer = dimmutable,
      Object? inputDeserializer = dimmutable,
      Object? errorDeserializer = dimmutable}) {
    return _then(_value.copyWith(
        responseDeserializer: responseDeserializer == dimmutable
            ? _value.responseDeserializer
            : responseDeserializer as R Function(int, dynamic),
        responseSerializer: responseSerializer == dimmutable
            ? _value.responseSerializer
            : responseSerializer as dynamic Function(int, R)?,
        transformer: transformer == dimmutable
            ? _value.transformer
            : transformer
                as HttpField<dynamic, dynamic, dynamic, dynamic> Function(
                    HttpField<dynamic, dynamic, dynamic, dynamic>,
                    HttpField<dynamic, dynamic, dynamic, dynamic>)?,
        inputSerializer: inputSerializer == dimmutable
            ? _value.inputSerializer
            : inputSerializer as dynamic Function(I)?,
        inputStorageSerializer: inputStorageSerializer == dimmutable
            ? _value.inputStorageSerializer
            : inputStorageSerializer as Future<dynamic> Function(I)?,
        inputDeserializer: inputDeserializer == dimmutable
            ? _value.inputDeserializer
            : inputDeserializer as I Function(dynamic)?,
        errorDeserializer: errorDeserializer == dimmutable
            ? _value.errorDeserializer
            : errorDeserializer as E Function(int, dynamic)?));
  }
}

abstract class _$HttpMetaCopyWith<I, R, E, T, O>
    implements $HttpMetaCopyWith<I, R, E, T, O> {
  factory _$HttpMetaCopyWith(
          HttpMeta<I, R, E, T> value, O Function(HttpMeta<I, R, E, T>) then) =
      __$HttpMetaCopyWithImpl<I, R, E, T, O>;
  O call(
      {R Function(int, dynamic) responseDeserializer,
      dynamic Function(int, R)? responseSerializer,
      HttpField<dynamic, dynamic, dynamic, dynamic> Function(
              HttpField<dynamic, dynamic, dynamic, dynamic>,
              HttpField<dynamic, dynamic, dynamic, dynamic>)?
          transformer,
      dynamic Function(I)? inputSerializer,
      Future<dynamic> Function(I)? inputStorageSerializer,
      I Function(dynamic)? inputDeserializer,
      E Function(int, dynamic)? errorDeserializer});
}

class __$HttpMetaCopyWithImpl<I, R, E, T, O>
    extends _$HttpMetaCopyWithImpl<I, R, E, T, O>
    implements _$HttpMetaCopyWith<I, R, E, T, O> {
  __$HttpMetaCopyWithImpl(
      HttpMeta<I, R, E, T> _value, O Function(HttpMeta<I, R, E, T>) _then)
      : super(_value, (v) => _then(v));

  @override
  HttpMeta<I, R, E, T> get _value => super._value;

  @override
  O call(
      {Object? responseDeserializer = dimmutable,
      Object? responseSerializer = dimmutable,
      Object? transformer = dimmutable,
      Object? inputSerializer = dimmutable,
      Object? inputStorageSerializer = dimmutable,
      Object? inputDeserializer = dimmutable,
      Object? errorDeserializer = dimmutable}) {
    return _then(HttpMeta(
        responseDeserializer: responseDeserializer == dimmutable
            ? _value.responseDeserializer
            : responseDeserializer as R Function(int, dynamic),
        responseSerializer: responseSerializer == dimmutable
            ? _value.responseSerializer
            : responseSerializer as dynamic Function(int, R)?,
        transformer: transformer == dimmutable
            ? _value.transformer
            : transformer
                as HttpField<dynamic, dynamic, dynamic, dynamic> Function(
                    HttpField<dynamic, dynamic, dynamic, dynamic>,
                    HttpField<dynamic, dynamic, dynamic, dynamic>)?,
        inputSerializer: inputSerializer == dimmutable
            ? _value.inputSerializer
            : inputSerializer as dynamic Function(I)?,
        inputStorageSerializer: inputStorageSerializer == dimmutable
            ? _value.inputStorageSerializer
            : inputStorageSerializer as Future<dynamic> Function(I)?,
        inputDeserializer: inputDeserializer == dimmutable
            ? _value.inputDeserializer
            : inputDeserializer as I Function(dynamic)?,
        errorDeserializer: errorDeserializer == dimmutable
            ? _value.errorDeserializer
            : errorDeserializer as E Function(int, dynamic)?));
  }
}

mixin _$HttpPayload<PP, QP, I, R, E, T> {
  String get url;
  I? get data;
  String get method;
  HttpResponseType get responseType;
  R? get optimisticResponse;
  int? get optimisticHttpStatus;
  bool get offline;
  Map<String, dynamic>? get headers;
  QP? get queryParams;
  PP? get pathParams;
  int? get sendTimeout;
  int? get receiveTieout;
  bool get abortable;

  $HttpPayloadCopyWith<PP, QP, I, R, E, T, HttpPayload<PP, QP, I, R, E, T>>
      get copyWith;
}

class _HttpPayload<PP, QP, I, R, E, T>
    implements HttpPayload<PP, QP, I, R, E, T> {
  @override
  final String url;

  @override
  final I? data;

  @override
  final String method;

  @override
  final HttpResponseType responseType;

  @override
  final R? optimisticResponse;

  @override
  final int? optimisticHttpStatus;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool offline;

  @override
  final Map<String, dynamic>? headers;

  @override
  final QP? queryParams;

  @override
  final PP? pathParams;

  @override
  final int? sendTimeout;

  @override
  final int? receiveTieout;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool abortable;

  _$HttpPayloadCopyWith<PP, QP, I, R, E, T, HttpPayload<PP, QP, I, R, E, T>>
      get copyWith => __$HttpPayloadCopyWithImpl<PP, QP, I, R, E, T,
          HttpPayload<PP, QP, I, R, E, T>>(this, IdentityFn);

  const _HttpPayload(
      {required this.url,
      this.data,
      required this.method,
      required this.responseType,
      this.optimisticResponse,
      this.optimisticHttpStatus,
      this.offline = false,
      this.headers,
      this.queryParams,
      this.pathParams,
      this.sendTimeout,
      this.receiveTieout,
      this.abortable = false});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _HttpPayload &&
        o.url == url &&
        o.data == data &&
        o.method == method &&
        o.responseType == responseType &&
        o.optimisticResponse == optimisticResponse &&
        o.optimisticHttpStatus == optimisticHttpStatus &&
        o.offline == offline &&
        o.headers == headers &&
        o.queryParams == queryParams &&
        o.pathParams == pathParams &&
        o.sendTimeout == sendTimeout &&
        o.receiveTieout == receiveTieout &&
        o.abortable == abortable;
  }

  @override
  int get hashCode =>
      url.hashCode ^
      data.hashCode ^
      method.hashCode ^
      responseType.hashCode ^
      optimisticResponse.hashCode ^
      optimisticHttpStatus.hashCode ^
      offline.hashCode ^
      headers.hashCode ^
      queryParams.hashCode ^
      pathParams.hashCode ^
      sendTimeout.hashCode ^
      receiveTieout.hashCode ^
      abortable.hashCode;

  @override
  String toString() =>
      "HttpPayload(url: ${this.url}, data: ${this.data}, method: ${this.method}, responseType: ${this.responseType}, optimisticResponse: ${this.optimisticResponse}, optimisticHttpStatus: ${this.optimisticHttpStatus}, offline: ${this.offline}, headers: ${this.headers}, queryParams: ${this.queryParams}, pathParams: ${this.pathParams}, sendTimeout: ${this.sendTimeout}, receiveTieout: ${this.receiveTieout}, abortable: ${this.abortable})";
}

abstract class $HttpPayloadCopyWith<PP, QP, I, R, E, T, O> {
  factory $HttpPayloadCopyWith(HttpPayload<PP, QP, I, R, E, T> value,
          O Function(HttpPayload<PP, QP, I, R, E, T>) then) =
      _$HttpPayloadCopyWithImpl<PP, QP, I, R, E, T, O>;
  O call(
      {String url,
      I? data,
      String method,
      HttpResponseType responseType,
      R? optimisticResponse,
      int? optimisticHttpStatus,
      bool offline,
      Map<String, dynamic>? headers,
      QP? queryParams,
      PP? pathParams,
      int? sendTimeout,
      int? receiveTieout,
      bool abortable});
}

class _$HttpPayloadCopyWithImpl<PP, QP, I, R, E, T, O>
    implements $HttpPayloadCopyWith<PP, QP, I, R, E, T, O> {
  final HttpPayload<PP, QP, I, R, E, T> _value;
  final O Function(HttpPayload<PP, QP, I, R, E, T>) _then;
  _$HttpPayloadCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? url = dimmutable,
      Object? data = dimmutable,
      Object? method = dimmutable,
      Object? responseType = dimmutable,
      Object? optimisticResponse = dimmutable,
      Object? optimisticHttpStatus = dimmutable,
      Object? offline = dimmutable,
      Object? headers = dimmutable,
      Object? queryParams = dimmutable,
      Object? pathParams = dimmutable,
      Object? sendTimeout = dimmutable,
      Object? receiveTieout = dimmutable,
      Object? abortable = dimmutable}) {
    return _then(_value.copyWith(
        url: url == dimmutable ? _value.url : url as String,
        data: data == dimmutable ? _value.data : data as I?,
        method: method == dimmutable ? _value.method : method as String,
        responseType: responseType == dimmutable
            ? _value.responseType
            : responseType as HttpResponseType,
        optimisticResponse: optimisticResponse == dimmutable
            ? _value.optimisticResponse
            : optimisticResponse as R?,
        optimisticHttpStatus: optimisticHttpStatus == dimmutable
            ? _value.optimisticHttpStatus
            : optimisticHttpStatus as int?,
        offline: offline == dimmutable ? _value.offline : offline as bool,
        headers: headers == dimmutable
            ? _value.headers
            : headers as Map<String, dynamic>?,
        queryParams:
            queryParams == dimmutable ? _value.queryParams : queryParams as QP?,
        pathParams:
            pathParams == dimmutable ? _value.pathParams : pathParams as PP?,
        sendTimeout: sendTimeout == dimmutable
            ? _value.sendTimeout
            : sendTimeout as int?,
        receiveTieout: receiveTieout == dimmutable
            ? _value.receiveTieout
            : receiveTieout as int?,
        abortable:
            abortable == dimmutable ? _value.abortable : abortable as bool));
  }
}

abstract class _$HttpPayloadCopyWith<PP, QP, I, R, E, T, O>
    implements $HttpPayloadCopyWith<PP, QP, I, R, E, T, O> {
  factory _$HttpPayloadCopyWith(HttpPayload<PP, QP, I, R, E, T> value,
          O Function(HttpPayload<PP, QP, I, R, E, T>) then) =
      __$HttpPayloadCopyWithImpl<PP, QP, I, R, E, T, O>;
  O call(
      {String url,
      I? data,
      String method,
      HttpResponseType responseType,
      R? optimisticResponse,
      int? optimisticHttpStatus,
      bool offline,
      Map<String, dynamic>? headers,
      QP? queryParams,
      PP? pathParams,
      int? sendTimeout,
      int? receiveTieout,
      bool abortable});
}

class __$HttpPayloadCopyWithImpl<PP, QP, I, R, E, T, O>
    extends _$HttpPayloadCopyWithImpl<PP, QP, I, R, E, T, O>
    implements _$HttpPayloadCopyWith<PP, QP, I, R, E, T, O> {
  __$HttpPayloadCopyWithImpl(HttpPayload<PP, QP, I, R, E, T> _value,
      O Function(HttpPayload<PP, QP, I, R, E, T>) _then)
      : super(_value, (v) => _then(v));

  @override
  HttpPayload<PP, QP, I, R, E, T> get _value => super._value;

  @override
  O call(
      {Object? url = dimmutable,
      Object? data = dimmutable,
      Object? method = dimmutable,
      Object? responseType = dimmutable,
      Object? optimisticResponse = dimmutable,
      Object? optimisticHttpStatus = dimmutable,
      Object? offline = dimmutable,
      Object? headers = dimmutable,
      Object? queryParams = dimmutable,
      Object? pathParams = dimmutable,
      Object? sendTimeout = dimmutable,
      Object? receiveTieout = dimmutable,
      Object? abortable = dimmutable}) {
    return _then(HttpPayload(
        url: url == dimmutable ? _value.url : url as String,
        data: data == dimmutable ? _value.data : data as I?,
        method: method == dimmutable ? _value.method : method as String,
        responseType: responseType == dimmutable
            ? _value.responseType
            : responseType as HttpResponseType,
        optimisticResponse: optimisticResponse == dimmutable
            ? _value.optimisticResponse
            : optimisticResponse as R?,
        optimisticHttpStatus: optimisticHttpStatus == dimmutable
            ? _value.optimisticHttpStatus
            : optimisticHttpStatus as int?,
        offline: offline == dimmutable ? _value.offline : offline as bool,
        headers: headers == dimmutable
            ? _value.headers
            : headers as Map<String, dynamic>?,
        queryParams:
            queryParams == dimmutable ? _value.queryParams : queryParams as QP?,
        pathParams:
            pathParams == dimmutable ? _value.pathParams : pathParams as PP?,
        sendTimeout: sendTimeout == dimmutable
            ? _value.sendTimeout
            : sendTimeout as int?,
        receiveTieout: receiveTieout == dimmutable
            ? _value.receiveTieout
            : receiveTieout as int?,
        abortable:
            abortable == dimmutable ? _value.abortable : abortable as bool));
  }
}
