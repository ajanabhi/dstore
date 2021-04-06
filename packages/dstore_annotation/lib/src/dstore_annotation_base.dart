import "package:collection/collection.dart";

class PState {
  final bool? persist;
  final bool enableHistory;
  final int? historyLimit;
  final bool? nav;
  const PState(
      {this.persist, this.enableHistory = false, this.historyLimit, this.nav});
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

extension HttpResponseTypeExt on HttpResponseType {
  String get value => toString().split(".").last;
  static HttpResponseType? fromValue(String value) {
    return HttpResponseType.values
        .singleWhereOrNull((e) => e.toString().split(".")[1] == value);
  }
}

enum HttpInputType { JSON, FORM, TEXT }

extension HttpInputTypeExt on HttpInputType {
  String get value => toString().split(".").last;
  static HttpInputType? fromValue(String value) {
    return HttpInputType.values
        .singleWhereOrNull((e) => e.toString().split(".")[1] == value);
  }
}

class HttpRequest<I, R, E> {
  final String method;
  final String url;
  final R Function(dynamic)? responseDeserializer;
  final dynamic Function(I)? inputSerializer;
  final dynamic Function(R)? responseSerializer;
  final I Function(dynamic)? inputDeserializer;
  final E Function(dynamic)? errorDeserializer;
  final HttpResponseType? responseType;
  final HttpInputType? inputType;
  final String? graphqlQuery;

  const HttpRequest(
      {required this.method,
      required this.url,
      this.responseSerializer,
      this.responseDeserializer,
      this.inputSerializer,
      this.responseType,
      this.inputDeserializer,
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

class DEnum {
  const DEnum();
}

class FormModel {
  const FormModel();
}

class Validator {
  final Function fn;
  const Validator(this.fn);
}

class DUnion {
  const DUnion();
}

class Url {
  final String path;
  const Url(this.path);
}

class OpenApi {
  final String file;

  OpenApi(this.file);
}
