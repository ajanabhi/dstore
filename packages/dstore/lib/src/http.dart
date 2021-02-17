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

class HttpPayload<I, R, E, T> {
  final String url;
  final I? data;
  final String method;
  final HttpResponseType responseType;
  final R? optimisticResponse;
  final HttpInputType? inputType;
  final R Function(dynamic) responseDeserializer;
  final HttpField Function(HttpField currentField, HttpField newField)?
      transformer;
  final dynamic Function(I)? inputSerializer;
  final E Function(dynamic)? errorDeserializer;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;
  final int? sendTimeout;
  final int? receiveTieout;
  final bool abortable;

  HttpPayload(
      {required this.url,
      this.inputSerializer,
      required this.method,
      this.data,
      this.transformer,
      required this.responseType,
      required this.responseDeserializer,
      this.errorDeserializer,
      this.inputType,
      this.headers,
      this.receiveTieout,
      this.queryParams,
      this.sendTimeout,
      this.optimisticResponse,
      this.abortable = false});
}

class GlobalHttpOptions {
  final Map<String, dynamic> headers;

  GlobalHttpOptions({this.headers = const {}});
}
