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
  final Map<String, String>? scalarMap;
  const GraphqlApi(
      {required this.apiUrl, this.schemaPath, this.wsUrl, this.scalarMap});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GraphqlApi && other.apiUrl == apiUrl;
  }

  @override
  int get hashCode {
    return apiUrl.hashCode;
  }
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

class HttpRequest {
  final String method;
  final String url;
  final Function? responseDeserializer;
  final Function? inputSerializer;
  final Function? responseSerializer;
  final Function? inputDeserializer;
  final Function? errorDeserializer;
  final HttpResponseType? responseType;
  final String? graphqlQuery;
  final Map<String, String>? headers;

  const HttpRequest({
    required this.method,
    required this.url,
    this.responseSerializer,
    this.responseDeserializer,
    this.inputSerializer,
    this.responseType,
    this.headers,
    this.inputDeserializer,
    this.errorDeserializer,
    this.graphqlQuery,
  });
}

class HttpRequestExtension<T> {
  final T Function(T)? transformer;

  const HttpRequestExtension({this.transformer});
}

class WebSocketRequest {
  final String url;
  final String? graphqlQuery;
  final Function? inputSerializer;
  final Function responseDeserializer;

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

  const OpenApi(this.file);
}
