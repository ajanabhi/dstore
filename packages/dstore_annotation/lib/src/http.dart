import 'package:collection/collection.dart';

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
