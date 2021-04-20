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
  final Map<String, String>? responseHeaders;
  final int? status;
  final bool completed;
  final bool optimistic;
  final bool offline;
  final AbortController? abortController;

  HttpField(
      {this.loading = false,
      this.data,
      this.error,
      this.responseHeaders,
      this.status,
      this.offline = false,
      this.abortController,
      this.completed = false,
      this.optimistic = false});

  HttpField<QP, I, R, E> copyWith(
      {bool? loading,
      Optional<R?> data = optionalDefault,
      Optional<AbortController?> abortController = optionalDefault,
      Optional<HttpError<E>?> error = optionalDefault,
      Optional<Map<String, String>?> responseHeaders = optionalDefault,
      Optional<int?> status = optionalDefault,
      bool? completed,
      bool? offline,
      bool? optimistic}) {
    return HttpField(
        loading: loading ?? this.loading,
        data: data == optionalDefault ? this.data : data.value,
        error: error == optionalDefault ? this.error : error.value,
        abortController: abortController == optionalDefault
            ? this.abortController
            : abortController.value,
        completed: completed ?? this.completed,
        responseHeaders: responseHeaders == optionalDefault
            ? this.responseHeaders
            : responseHeaders.value,
        status: status == optionalDefault ? this.status : status.value,
        optimistic: optimistic ?? this.optimistic,
        offline: offline ?? this.offline);
  }
}

@DImmutable()
abstract class Httpmeta<I, R, E, T> with _$Httpmeta<I, R, E, T> {
  const factory Httpmeta({
    required R Function(int status, dynamic resp) responseDeserializer,
    dynamic Function(int, R)? responseSerializer,
    HttpField Function(HttpField currentField, HttpField newField)? transformer,
    dynamic Function(I)? inputSerializer,
    Future<dynamic> Function(I)? inputStorageSerializer,
    I Function(dynamic)? inputDeserializer,
    E Function(int status, dynamic resp)? errorDeserializer,
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
      int? optimisticHttpStatus,
      @Default(false) bool offline,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams,
      int? sendTimeout,
      int? receiveTieout,
      @Default(false) bool abortable}) = _HttpPayload<I, R, E, T>;

  factory HttpPayload.fromJson(
      Map<String, dynamic> map, Httpmeta<I, R, E, T> meta) {
    final url = map["url"] as String;
    final method = map["method"] as String;
    final responseType =
        HttpResponseTypeExt.fromValue(map["responseType"] as String)!;
    var data = map["data"] as I?;
    if (data != null) {
      if (meta.inputDeserializer == null) {
        throw ArgumentError.value(
            "You should provide inputDeserializer for http field");
      }
      data = meta.inputDeserializer!(data);
    }
    var optimisticResponse = map["optimisticResponse"] as R?;
    if (optimisticResponse != null) {
      optimisticResponse = meta.responseDeserializer(200, optimisticResponse);
    }

    final inputTypeS = map["inputType"] as String?;
    HttpInputType? inputType;
    if (inputTypeS != null) {
      inputType = HttpInputTypeExt.fromValue(inputTypeS);
    }
    final headers = map["headers"] as Map<String, dynamic>?;
    final queryParams = map["queryParams"] as Map<String, dynamic>?;
    final sendTimeout = map["sendTimeout"] as int?;
    final receiveTieout = map["receiveTieout"] as int?;
    final abortable = map["abortable"] as bool;

    return HttpPayload(
        url: url,
        method: method,
        responseType: responseType,
        data: data,
        optimisticResponse: optimisticResponse,
        inputType: inputType,
        headers: headers,
        queryParams: queryParams,
        sendTimeout: sendTimeout,
        receiveTieout: receiveTieout,
        abortable: abortable);
  }
}

extension HttpPayloadExt on HttpPayload {
  Map<String, dynamic> toJson(Httpmeta meta) {
    final map = <String, dynamic>{};
    map["url"] = url;
    map["method"] = method;
    if (data != null) {
      if (meta.inputSerializer == null) {
        throw ArgumentError.value(
            "You should provide inputSerializer for http field");
      }
      map["data"] = meta.inputSerializer!(data);
    }
    map["responseType"] = responseType.value;
    if (optimisticResponse != null && optimisticHttpStatus != null) {
      if (meta.responseSerializer == null) {
        throw ArgumentError.value(
            "You should provide responseSerializer for http field");
      }
      map["optimisticResponse"] =
          meta.responseSerializer!(optimisticHttpStatus!, optimisticResponse);
    }
    if (inputType != null) {
      map["inputType"] = inputType!.value;
    }
    if (headers != null) {
      map["headers"] = headers;
    }
    if (headers != null) {
      map["queryParams"] = queryParams;
    }
    if (sendTimeout != null) {
      map["sendTimeout"] = sendTimeout;
    }
    if (receiveTieout != null) {
      map["receiveTieout"] = receiveTieout;
    }
    map["abortable"] = abortable;
    return map;
  }
}

class GlobalHttpOptions {
  Map<String, dynamic> headers;

  GlobalHttpOptions({this.headers = const <String, dynamic>{}});
}
