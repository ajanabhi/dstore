import 'package:dstore/dstore.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import "package:json_annotation/json_annotation.dart";

part "http.dstore.dart";

@DImmutable()
abstract class Hello with _$Hello {
  const factory Hello({required String name}) = _Hello;
}

String getTodosSerializer(dynamic resp) {
  return "";
}

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

  HttpField(
      {this.loading = false,
      this.data,
      this.error,
      this.completed = false,
      this.optimistic = false});

  HttpField<QP, I, R, E> copyWith(
      {bool? loading,
      Optional<R?> data = optionalDefault,
      Optional<HttpError<E>?> error = optionalDefault,
      bool? completed,
      bool? optimistic}) {
    return HttpField(
        loading: loading ?? this.loading,
        data: data == optionalDefault ? this.data : data.value,
        error: error == optionalDefault ? this.error : error.value,
        completed: completed ?? this.completed,
        optimistic: optimistic ?? this.optimistic);
  }
}

@DImmutable()
abstract class Httpmeta<I, R, E, T> with _$Httpmeta<I, R, E, T> {
  const factory Httpmeta({
    required R Function(dynamic) responseDeserializer,
    dynamic Function(R)? responseSerializer,
    HttpField Function(HttpField currentField, HttpField newField)? transformer,
    dynamic Function(I)? inputSerializer,
    Future<dynamic> Function(I)? inputStorageSerializer,
    Future<I> Function(dynamic)? inputDeserializer,
    E Function(dynamic)? errorDeserializer,
  }) = _Httpmeta<I, R, E, T>;
}

@DImmutable()
abstract class HttpPayload<I, R, E, T> with _$HttpPayload<I, R, E, T> {
  const factory HttpPayload(
      {required String url,
      I? data,
      required String method,
      required HttpResponseType responseType,
      R? optimisticResponse,
      HttpInputType? inputType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams,
      int? sendTimeout,
      int? receiveTieout,
      @Default(false) bool abortable}) = _HttpPayload<I, R, E, T>;
}

class GlobalHttpOptions {
  Map<String, dynamic> headers;

  GlobalHttpOptions({this.headers = const {}});
}
