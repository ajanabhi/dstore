class PState {
  final bool persist;
  const PState({this.persist = false});
}

class Selectors {
  const Selectors();
}

class AppStateAnnotation {
  const AppStateAnnotation();
}

class GraphqlApi {
  final String apiUrl;
  final String? schemaPath;
  final String? wsUrl;
  const GraphqlApi({required this.apiUrl, this.schemaPath, this.wsUrl});
}

class GraphqlOps {
  final GraphqlApi api;
  const GraphqlOps(this.api);
}

class DImmutable {
  const DImmutable();
}

const dimmutable = DImmutable();

class PersistKey {
  final bool ignore;
  const PersistKey({this.ignore = false});
}

class Default {
  const Default(dynamic value);
}

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

class HttpRequestExtension<T> {
  final T Function(T)? transformer;

  const HttpRequestExtension({this.transformer});
}

class WebSocketRequest<I, R> {
  final String url;
  final String? graphqlQuery;
  final dynamic Function(I)? inputSerializer;
  final R Function(dynamic) responseDeserializer;

  const WebSocketRequest(
      {required this.url,
      this.graphqlQuery,
      this.inputSerializer,
      required this.responseDeserializer});
}

class WebSocketRequestExtension<T> {
  final T Function(T)? transformer;

  const WebSocketRequestExtension({this.transformer});
}

class ExcludeThisKeyWhilePersit {
  const ExcludeThisKeyWhilePersit();
}

const excludeThisKeyWhilePersist = ExcludeThisKeyWhilePersit();
