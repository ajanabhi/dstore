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

mixin _$HttpField<QP, I, R, E> {
  bool get loading;
  R? get data;
  HttpError<E>? get error;
  bool get completed;
  bool get optimistic;
  AbortController? get abortController;

  $HttpFieldCopyWith<QP, I, R, E, HttpField<QP, I, R, E>> get copyWith;
}

class _HttpField<QP, I, R, E> implements HttpField<QP, I, R, E> {
  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool loading;

  @override
  final R? data;

  @override
  final HttpError<E>? error;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool completed;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool optimistic;

  @override
  final AbortController? abortController;

  _$HttpFieldCopyWith<QP, I, R, E, HttpField<QP, I, R, E>> get copyWith =>
      __$HttpFieldCopyWithImpl<QP, I, R, E, HttpField<QP, I, R, E>>(
          this, IdentityFn);

  const _HttpField(
      {this.loading = false,
      this.data,
      this.error,
      this.completed = false,
      this.optimistic = false,
      this.abortController});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _HttpField &&
        o.loading == loading &&
        o.data == data &&
        o.error == error &&
        o.completed == completed &&
        o.optimistic == optimistic &&
        o.abortController == abortController;
  }

  @override
  int get hashCode =>
      loading.hashCode ^
      data.hashCode ^
      error.hashCode ^
      completed.hashCode ^
      optimistic.hashCode ^
      abortController.hashCode;

  @override
  String toString() =>
      "HttpField(loading: ${this.loading}, data: ${this.data}, error: ${this.error}, completed: ${this.completed}, optimistic: ${this.optimistic}, abortController: ${this.abortController})";
}

abstract class $HttpFieldCopyWith<QP, I, R, E, O> {
  factory $HttpFieldCopyWith(HttpField<QP, I, R, E> value,
          O Function(HttpField<QP, I, R, E>) then) =
      _$HttpFieldCopyWithImpl<QP, I, R, E, O>;
  O call(
      {bool loading,
      R? data,
      HttpError<E>? error,
      bool completed,
      bool optimistic,
      AbortController? abortController});
}

class _$HttpFieldCopyWithImpl<QP, I, R, E, O>
    implements $HttpFieldCopyWith<QP, I, R, E, O> {
  final HttpField<QP, I, R, E> _value;
  final O Function(HttpField<QP, I, R, E>) _then;
  _$HttpFieldCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? loading = dimmutable,
      Object? data = dimmutable,
      Object? error = dimmutable,
      Object? completed = dimmutable,
      Object? optimistic = dimmutable,
      Object? abortController = dimmutable}) {
    return _then(_value.copyWith(
        loading: loading == dimmutable ? _value.loading : loading as bool,
        data: data == dimmutable ? _value.data : data as R?,
        error: error == dimmutable ? _value.error : error as HttpError<E>?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool,
        optimistic:
            optimistic == dimmutable ? _value.optimistic : optimistic as bool,
        abortController: abortController == dimmutable
            ? _value.abortController
            : abortController as AbortController?));
  }
}

abstract class _$HttpFieldCopyWith<QP, I, R, E, O>
    implements $HttpFieldCopyWith<QP, I, R, E, O> {
  factory _$HttpFieldCopyWith(HttpField<QP, I, R, E> value,
          O Function(HttpField<QP, I, R, E>) then) =
      __$HttpFieldCopyWithImpl<QP, I, R, E, O>;
  O call(
      {bool loading,
      R? data,
      HttpError<E>? error,
      bool completed,
      bool optimistic,
      AbortController? abortController});
}

class __$HttpFieldCopyWithImpl<QP, I, R, E, O>
    extends _$HttpFieldCopyWithImpl<QP, I, R, E, O>
    implements _$HttpFieldCopyWith<QP, I, R, E, O> {
  __$HttpFieldCopyWithImpl(
      HttpField<QP, I, R, E> _value, O Function(HttpField<QP, I, R, E>) _then)
      : super(_value, (v) => _then(v));

  @override
  HttpField<QP, I, R, E> get _value => super._value;

  @override
  O call(
      {Object? loading = dimmutable,
      Object? data = dimmutable,
      Object? error = dimmutable,
      Object? completed = dimmutable,
      Object? optimistic = dimmutable,
      Object? abortController = dimmutable}) {
    return _then(HttpField(
        loading: loading == dimmutable ? _value.loading : loading as bool,
        data: data == dimmutable ? _value.data : data as R?,
        error: error == dimmutable ? _value.error : error as HttpError<E>?,
        completed:
            completed == dimmutable ? _value.completed : completed as bool,
        optimistic:
            optimistic == dimmutable ? _value.optimistic : optimistic as bool,
        abortController: abortController == dimmutable
            ? _value.abortController
            : abortController as AbortController?));
  }
}

mixin _$Httpmeta<I, R, E, T> {
  R Function(dynamic) get responseDeserializer;
  dynamic Function(R)? get responseSerializer;
  HttpField<dynamic, dynamic, dynamic, dynamic> Function(
      HttpField<dynamic, dynamic, dynamic, dynamic>,
      HttpField<dynamic, dynamic, dynamic, dynamic>)? get transformer;
  dynamic Function(I)? get inputSerializer;
  Future<dynamic> Function(I)? get inputStorageSerializer;
  Future<I> Function(dynamic)? get inputDeserializer;
  E Function(dynamic)? get errorDeserializer;

  $HttpmetaCopyWith<I, R, E, T, Httpmeta<I, R, E, T>> get copyWith;
}

class _Httpmeta<I, R, E, T> implements Httpmeta<I, R, E, T> {
  @override
  final R Function(dynamic) responseDeserializer;

  @override
  final dynamic Function(R)? responseSerializer;

  @override
  final HttpField<dynamic, dynamic, dynamic, dynamic> Function(
      HttpField<dynamic, dynamic, dynamic, dynamic>,
      HttpField<dynamic, dynamic, dynamic, dynamic>)? transformer;

  @override
  final dynamic Function(I)? inputSerializer;

  @override
  final Future<dynamic> Function(I)? inputStorageSerializer;

  @override
  final Future<I> Function(dynamic)? inputDeserializer;

  @override
  final E Function(dynamic)? errorDeserializer;

  _$HttpmetaCopyWith<I, R, E, T, Httpmeta<I, R, E, T>> get copyWith =>
      __$HttpmetaCopyWithImpl<I, R, E, T, Httpmeta<I, R, E, T>>(
          this, IdentityFn);

  const _Httpmeta(
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
    return o is _Httpmeta &&
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
      "Httpmeta(responseDeserializer: ${this.responseDeserializer}, responseSerializer: ${this.responseSerializer}, transformer: ${this.transformer}, inputSerializer: ${this.inputSerializer}, inputStorageSerializer: ${this.inputStorageSerializer}, inputDeserializer: ${this.inputDeserializer}, errorDeserializer: ${this.errorDeserializer})";
}

abstract class $HttpmetaCopyWith<I, R, E, T, O> {
  factory $HttpmetaCopyWith(
          Httpmeta<I, R, E, T> value, O Function(Httpmeta<I, R, E, T>) then) =
      _$HttpmetaCopyWithImpl<I, R, E, T, O>;
  O call(
      {R Function(dynamic) responseDeserializer,
      dynamic Function(R)? responseSerializer,
      HttpField<dynamic, dynamic, dynamic, dynamic> Function(
              HttpField<dynamic, dynamic, dynamic, dynamic>,
              HttpField<dynamic, dynamic, dynamic, dynamic>)?
          transformer,
      dynamic Function(I)? inputSerializer,
      Future<dynamic> Function(I)? inputStorageSerializer,
      Future<I> Function(dynamic)? inputDeserializer,
      E Function(dynamic)? errorDeserializer});
}

class _$HttpmetaCopyWithImpl<I, R, E, T, O>
    implements $HttpmetaCopyWith<I, R, E, T, O> {
  final Httpmeta<I, R, E, T> _value;
  final O Function(Httpmeta<I, R, E, T>) _then;
  _$HttpmetaCopyWithImpl(this._value, this._then);

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
            : responseDeserializer as R Function(dynamic),
        responseSerializer: responseSerializer == dimmutable
            ? _value.responseSerializer
            : responseSerializer as dynamic Function(R)?,
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
            : inputDeserializer as Future<I> Function(dynamic)?,
        errorDeserializer: errorDeserializer == dimmutable
            ? _value.errorDeserializer
            : errorDeserializer as E Function(dynamic)?));
  }
}

abstract class _$HttpmetaCopyWith<I, R, E, T, O>
    implements $HttpmetaCopyWith<I, R, E, T, O> {
  factory _$HttpmetaCopyWith(
          Httpmeta<I, R, E, T> value, O Function(Httpmeta<I, R, E, T>) then) =
      __$HttpmetaCopyWithImpl<I, R, E, T, O>;
  O call(
      {R Function(dynamic) responseDeserializer,
      dynamic Function(R)? responseSerializer,
      HttpField<dynamic, dynamic, dynamic, dynamic> Function(
              HttpField<dynamic, dynamic, dynamic, dynamic>,
              HttpField<dynamic, dynamic, dynamic, dynamic>)?
          transformer,
      dynamic Function(I)? inputSerializer,
      Future<dynamic> Function(I)? inputStorageSerializer,
      Future<I> Function(dynamic)? inputDeserializer,
      E Function(dynamic)? errorDeserializer});
}

class __$HttpmetaCopyWithImpl<I, R, E, T, O>
    extends _$HttpmetaCopyWithImpl<I, R, E, T, O>
    implements _$HttpmetaCopyWith<I, R, E, T, O> {
  __$HttpmetaCopyWithImpl(
      Httpmeta<I, R, E, T> _value, O Function(Httpmeta<I, R, E, T>) _then)
      : super(_value, (v) => _then(v));

  @override
  Httpmeta<I, R, E, T> get _value => super._value;

  @override
  O call(
      {Object? responseDeserializer = dimmutable,
      Object? responseSerializer = dimmutable,
      Object? transformer = dimmutable,
      Object? inputSerializer = dimmutable,
      Object? inputStorageSerializer = dimmutable,
      Object? inputDeserializer = dimmutable,
      Object? errorDeserializer = dimmutable}) {
    return _then(Httpmeta(
        responseDeserializer: responseDeserializer == dimmutable
            ? _value.responseDeserializer
            : responseDeserializer as R Function(dynamic),
        responseSerializer: responseSerializer == dimmutable
            ? _value.responseSerializer
            : responseSerializer as dynamic Function(R)?,
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
            : inputDeserializer as Future<I> Function(dynamic)?,
        errorDeserializer: errorDeserializer == dimmutable
            ? _value.errorDeserializer
            : errorDeserializer as E Function(dynamic)?));
  }
}

mixin _$HttpPayload<I, R, E, T> {
  String get url;
  I? get data;
  String get method;
  HttpResponseType get responseType;
  R? get optimisticResponse;
  HttpInputType? get inputType;
  Map<String, dynamic>? get headers;
  Map<String, dynamic>? get queryParams;
  int? get sendTimeout;
  int? get receiveTieout;
  bool get abortable;

  $HttpPayloadCopyWith<I, R, E, T, HttpPayload<I, R, E, T>> get copyWith;
}

class _HttpPayload<I, R, E, T> implements HttpPayload<I, R, E, T> {
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
  final HttpInputType? inputType;

  @override
  final Map<String, dynamic>? headers;

  @override
  final Map<String, dynamic>? queryParams;

  @override
  final int? sendTimeout;

  @override
  final int? receiveTieout;

  @override
  @Default(false)
  @JsonKey(defaultValue: false)
  final bool abortable;

  _$HttpPayloadCopyWith<I, R, E, T, HttpPayload<I, R, E, T>> get copyWith =>
      __$HttpPayloadCopyWithImpl<I, R, E, T, HttpPayload<I, R, E, T>>(
          this, IdentityFn);

  const _HttpPayload(
      {required this.url,
      this.data,
      required this.method,
      required this.responseType,
      this.optimisticResponse,
      this.inputType,
      this.headers,
      this.queryParams,
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
        o.inputType == inputType &&
        o.headers == headers &&
        o.queryParams == queryParams &&
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
      inputType.hashCode ^
      headers.hashCode ^
      queryParams.hashCode ^
      sendTimeout.hashCode ^
      receiveTieout.hashCode ^
      abortable.hashCode;

  @override
  String toString() =>
      "HttpPayload(url: ${this.url}, data: ${this.data}, method: ${this.method}, responseType: ${this.responseType}, optimisticResponse: ${this.optimisticResponse}, inputType: ${this.inputType}, headers: ${this.headers}, queryParams: ${this.queryParams}, sendTimeout: ${this.sendTimeout}, receiveTieout: ${this.receiveTieout}, abortable: ${this.abortable})";
}

abstract class $HttpPayloadCopyWith<I, R, E, T, O> {
  factory $HttpPayloadCopyWith(HttpPayload<I, R, E, T> value,
          O Function(HttpPayload<I, R, E, T>) then) =
      _$HttpPayloadCopyWithImpl<I, R, E, T, O>;
  O call(
      {String url,
      I? data,
      String method,
      HttpResponseType responseType,
      R? optimisticResponse,
      HttpInputType? inputType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams,
      int? sendTimeout,
      int? receiveTieout,
      bool abortable});
}

class _$HttpPayloadCopyWithImpl<I, R, E, T, O>
    implements $HttpPayloadCopyWith<I, R, E, T, O> {
  final HttpPayload<I, R, E, T> _value;
  final O Function(HttpPayload<I, R, E, T>) _then;
  _$HttpPayloadCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? url = dimmutable,
      Object? data = dimmutable,
      Object? method = dimmutable,
      Object? responseType = dimmutable,
      Object? optimisticResponse = dimmutable,
      Object? inputType = dimmutable,
      Object? headers = dimmutable,
      Object? queryParams = dimmutable,
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
        inputType: inputType == dimmutable
            ? _value.inputType
            : inputType as HttpInputType?,
        headers: headers == dimmutable
            ? _value.headers
            : headers as Map<String, dynamic>?,
        queryParams: queryParams == dimmutable
            ? _value.queryParams
            : queryParams as Map<String, dynamic>?,
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

abstract class _$HttpPayloadCopyWith<I, R, E, T, O>
    implements $HttpPayloadCopyWith<I, R, E, T, O> {
  factory _$HttpPayloadCopyWith(HttpPayload<I, R, E, T> value,
          O Function(HttpPayload<I, R, E, T>) then) =
      __$HttpPayloadCopyWithImpl<I, R, E, T, O>;
  O call(
      {String url,
      I? data,
      String method,
      HttpResponseType responseType,
      R? optimisticResponse,
      HttpInputType? inputType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams,
      int? sendTimeout,
      int? receiveTieout,
      bool abortable});
}

class __$HttpPayloadCopyWithImpl<I, R, E, T, O>
    extends _$HttpPayloadCopyWithImpl<I, R, E, T, O>
    implements _$HttpPayloadCopyWith<I, R, E, T, O> {
  __$HttpPayloadCopyWithImpl(
      HttpPayload<I, R, E, T> _value, O Function(HttpPayload<I, R, E, T>) _then)
      : super(_value, (v) => _then(v));

  @override
  HttpPayload<I, R, E, T> get _value => super._value;

  @override
  O call(
      {Object? url = dimmutable,
      Object? data = dimmutable,
      Object? method = dimmutable,
      Object? responseType = dimmutable,
      Object? optimisticResponse = dimmutable,
      Object? inputType = dimmutable,
      Object? headers = dimmutable,
      Object? queryParams = dimmutable,
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
        inputType: inputType == dimmutable
            ? _value.inputType
            : inputType as HttpInputType?,
        headers: headers == dimmutable
            ? _value.headers
            : headers as Map<String, dynamic>?,
        queryParams: queryParams == dimmutable
            ? _value.queryParams
            : queryParams as Map<String, dynamic>?,
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
