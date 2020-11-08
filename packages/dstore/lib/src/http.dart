import 'package:meta/meta.dart';

enum HttpErrorType { NoNetWork, ResponseError, Aborted, Timeout }

class HttpError<RE> {
  final HttpErrorType type;
  final String message;
  final RE error;

  HttpError({@required this.type, this.message, this.error});
}

enum DSHttpResponseType { JSON, STRING, BYTES, STREAM }

enum DSHttpInputType { JSON, FORM, TEXT }

class DSHttpRequest {
  final String method;
  final String url;
  final DSHttpResponseType responseType;
  final DSHttpInputType inputType;

  const DSHttpRequest(
      {@required this.method,
      @required this.url,
      this.responseType,
      this.inputType});
}

@DSHttpRequest(method: "GET", url: "", responseType: DSHttpResponseType.JSON)
class GetTodos = HttpField<Null, Null, String> with EmptyMixin;

GetTodos gs = GetTodos();

mixin EmptyMixin {}

class Stuff<T> {
  T value;
  Stuff(this.value);
}

abstract class AbortController {
  void abort();
}

@DSHttpRequest(method: "GET", url: "")
class GetTodo = HttpField<Null, Null, String> with EmptyMixin;

class HttpField<I, R, E> {
  final bool loading;
  final R data;
  final HttpError error;
  final bool completed;
  final AbortController abortController;
  const HttpField(
      {this.loading = false,
      this.data,
      this.error,
      this.completed = false,
      this.abortController});

  HttpField<I, R, E> copyWith({
    bool loading,
    R data,
    HttpError error,
    bool completed,
    AbortController abortController,
  }) {
    return HttpField<I, R, E>(
        loading: loading ?? this.loading,
        data: data ?? this.data,
        error: error ?? this.error,
        completed: completed ?? this.completed,
        abortController: abortController ?? this.abortController);
  }

  @override
  String toString() =>
      'HttpResult(loading: $loading, data: $data, error: $error)';
}

class HttpPayload {
  final String url;
  final dynamic data;
  final String method;
  final DSHttpResponseType responseType;
  final DSHttpInputType inputType;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> queryParams;
  final int sendTimeout;
  final int receiveTieout;
  final bool offline;
  final bool abortable;

  HttpPayload(
      {@required this.url,
      @required this.method,
      this.data,
      @required this.responseType,
      this.inputType,
      this.headers,
      this.receiveTieout,
      this.queryParams,
      this.sendTimeout,
      this.offline,
      this.abortable});
}

class GlobalHttpOptions {
  final Map<String, dynamic> headers;

  GlobalHttpOptions({this.headers});
}
