import 'dart:convert';

import 'package:dstore/dstore.dart';

enum HttpErrorType {
  Default,
  Response,
  Aborted,
  ConnectTimeout,
  SendTimeout,
  ReceiveTimeout
}

class HttpError<RE> {
  final HttpErrorType type;
  final String? message;
  final RE? error;

  HttpError({required this.type, this.message, this.error});
}

enum HttpResponseType { JSON, STRING, BYTES, STREAM }

enum HttpInputType { JSON, FORM, TEXT }

class HttpRequestExtension {
  final HttpField Function(HttpField)? transformer;

  const HttpRequestExtension({this.transformer});
}

class HttpRequest<I, R, E> {
  final String method;
  final String url;
  final R Function(dynamic)? responseDeserializer;
  final dynamic Function(I)? inputSerializer;
  final E Function(dynamic)? errorDeserializer;
  final HttpResponseType? responseType;
  final HttpInputType? inputType;
  final String? graphqlQuery;

  const HttpRequest(
      {required this.method,
      required this.url,
      this.responseDeserializer,
      this.inputSerializer,
      this.responseType,
      this.errorDeserializer,
      this.graphqlQuery,
      this.inputType});
}

String getTodosSerializer(dynamic resp) {
  return "";
}

@HttpRequest(
    method: "GET",
    url: "",
    responseType: HttpResponseType.JSON,
    responseDeserializer: getTodosSerializer)
class GetTodos = HttpField<Null, Null, Null, String> with EmptyMixin;

GetTodos gs = GetTodos();

mixin EmptyMixin {}

class Stuff<T> {
  T value;
  Stuff(this.value);
}

abstract class AbortController {
  void abort();
}

@HttpRequest(method: "GET", url: "")
class GetTodo = HttpField<Null, Null, Null, String> with EmptyMixin;

class HttpField<QP, I, R, E> {
  final bool loading;
  final R? data;
  final HttpError<E>? error;
  final bool completed;
  final bool optimistic;
  final AbortController? abortController;
  const HttpField(
      {this.loading = false,
      this.data,
      this.error,
      this.optimistic = false,
      this.completed = false,
      this.abortController});

  HttpField<QP, I, R, E> copyWith({
    bool? loading,
    R? data,
    HttpError<E>? error,
    bool? completed,
    AbortController? abortController,
  }) {
    return HttpField<QP, I, R, E>(
        loading: loading ?? this.loading,
        data: data ?? this.data,
        error: error ?? this.error,
        completed: completed ?? this.completed,
        abortController: abortController ?? this.abortController);
  }

  @override
  String toString() =>
      'HttpField(loading: $loading, data: $data, error: $error)';
}

class HttpMeta<I, R, E, T> {
  final R Function(dynamic) responseDeserializer;
  final dynamic Function(R)? responseSerializer;
  final HttpField Function(HttpField currentField, HttpField newField)?
      transformer;
  final dynamic Function(I)? inputSerializer;
  final Future<dynamic> Function(I)? inputStorageSerializer;
  final Future<I> Function(dynamic)? inputDeserializer;
  final E Function(dynamic)? errorDeserializer;

  HttpMeta(
      {required this.responseDeserializer,
      this.transformer,
      this.inputStorageSerializer,
      this.inputSerializer,
      this.responseSerializer,
      this.inputDeserializer,
      this.errorDeserializer});
}

class HttpPayload<I, R, E, T> {
  final String url;
  final I? data;
  final String method;
  final HttpResponseType responseType;
  final R? optimisticResponse;
  final HttpInputType? inputType;

  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;
  final int? sendTimeout;
  final int? receiveTieout;
  final bool abortable;

  HttpPayload(
      {required this.url,
      required this.method,
      this.data,
      required this.responseType,
      this.inputType,
      this.headers,
      this.receiveTieout,
      this.queryParams,
      this.sendTimeout,
      this.optimisticResponse,
      this.abortable = false});

  Future<Map<String, dynamic>> toJson(
      {Future<dynamic> Function(I)? inputSerializer,
      dynamic Function(R)? responseSerializer}) async {
    dynamic data = this.data;
    if (inputSerializer != null) {
      data = await inputSerializer(data);
    }
    dynamic or = optimisticResponse;
    if (or != null && responseSerializer != null) {
      or = responseSerializer(or);
    }
    return {
      'url': url,
      'data': data,
      'method': method,
      'responseType': convertEnumOrNullToString(responseType),
      'optimisticResponse': or,
      'inputType': convertEnumOrNullToString(inputType),
      'headers': headers,
      'queryParams': queryParams,
      'sendTimeout': sendTimeout,
      'receiveTieout': receiveTieout,
      'abortable': abortable,
    };
  }
}

class GlobalHttpOptions {
  final Map<String, dynamic> headers;

  GlobalHttpOptions({this.headers = const {}});
}
