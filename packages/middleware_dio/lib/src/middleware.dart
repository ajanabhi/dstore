import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:dstore/dstore.dart';

//TODO upload download progress

class _DioAbort extends AbortController {
  final CancelToken token;
  _DioAbort(this.token);
  @override
  void abort() {
    token.cancel();
  }
}

Options _getOptions(
    HttpPayload payload, DioMiddlewareOptions? middlewareOptions) {
  final url = payload.url;
  GlobalHttpOptions? go;
  if (middlewareOptions != null) {
    for (final me in middlewareOptions.urlOptions.entries) {
      if (url.startsWith(me.key)) {
        go = me.value();
      }
    }
  }
  String? contentType;
  switch (payload.inputType) {
    case HttpInputType.JSON:
      contentType = Headers.jsonContentType;
      break;
    case HttpInputType.FORM:
      contentType = Headers.formUrlEncodedContentType;
      break;
    case HttpInputType.TEXT:
      contentType = "text/plain;charset=UTF-8";
      break;
    default:
      contentType = null;
  }
  ResponseType responseType;
  switch (payload.responseType) {
    case HttpResponseType.JSON:
      responseType = ResponseType.json;
      break;
    case HttpResponseType.STRING:
      responseType = ResponseType.plain;
      break;
    case HttpResponseType.BYTES:
      responseType = ResponseType.bytes;
      break;
    case HttpResponseType.STREAM:
      responseType = ResponseType.stream;
      break;
  }
  final headers = <String, dynamic>{};
  if (go?.headers != null) {
    headers.addAll(go!.headers);
  }
  headers.addAll(payload.headers ?? {});
  return Options(
      contentType: contentType,
      headers: headers,
      responseType: responseType,
      sendTimeout: payload.sendTimeout,
      receiveTimeout: payload.receiveTieout);
}

void _processHttpAction(DioMiddlewareOptions? middlewareOptions, Store store,
    Action action, Dio dio) async {
  final payload = action.http!;
  final field = store.getFieldFromAction(action) as HttpField;
  CancelToken? cancelToken;
  AbortController? abortController;
  if (payload.abortable) {
    cancelToken = CancelToken();
    abortController = _DioAbort(cancelToken);
  }
  final options = _getOptions(payload, middlewareOptions);
  if (payload.optimisticResponse != null) {
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.DATA,
            data: HttpField(
                data: payload.optimisticResponse,
                abortController: abortController,
                optimistic: true))));
  } else {
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.DATA,
            data: HttpField(loading: true, abortController: abortController))));
  }
  late final Response? response;
  try {
    var data = payload.data;
    if (payload.inputSerializer != null) {
      data = payload.inputSerializer!(data);
    }
    response = await dio.request(payload.url,
        data: data,
        queryParameters: payload.queryParams,
        cancelToken: cancelToken,
        options: options);
  } on DioError catch (e) {
    HttpError? error;
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        error =
            HttpError(type: HttpErrorType.ConnectTimeout, message: e.message);
        break;
      case DioErrorType.SEND_TIMEOUT:
        error = HttpError(type: HttpErrorType.SendTimeout, message: e.message);
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        error =
            HttpError(type: HttpErrorType.ReceiveTimeout, message: e.message);
        break;
      case DioErrorType.RESPONSE:
        var re = e.response;
        if (payload.errorDeserializer != null) {
          re = payload.errorDeserializer!(re);
        }
        error = HttpError(type: HttpErrorType.Response, error: re);
        break;
      case DioErrorType.CANCEL:
        error = HttpError(type: HttpErrorType.Aborted, message: e.message);
        break;
      case DioErrorType.DEFAULT:
        error = HttpError(type: HttpErrorType.Default, message: e.message);
        break;
    }
    var ef = HttpField(error: error);
    if (payload.transformer != null) {
      ef = payload.transformer!(field, ef);
    }
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true, type: ActionInternalType.DATA, data: ef)));
  }
  if (response != null) {
    late HttpField hf;
    if (payload.data is GraphqlRequestInput) {
      // graphql request
      HttpError? ge;
      if (response.data["errors"] != null) {
        // in graphql response we will get errors from successfull response also
        final ea = (response.data["errors"] as List<dynamic>)
            .map((e) => GraphqlError.fromJson(e))
            .toList();
        ge = HttpError(type: HttpErrorType.Response, error: ea);
      }
      dynamic? rdata;
      if (response.data["data"] != null) {
        rdata = payload.responseDeserializer(response.data["data"]);
      }
      hf = HttpField(error: ge, data: rdata);
    } else {
      var data = payload.responseDeserializer(response.data);
      hf = HttpField(data: data);
    }
    if (payload.transformer != null) {
      hf = payload.transformer!(field, hf);
    }
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true, type: ActionInternalType.DATA, data: hf)));
  }
}

class DioMiddlewareOptions {
  final Map<String, GlobalHttpOptions Function()> urlOptions;

  DioMiddlewareOptions({required this.urlOptions});
}

Middleware<S> createDioMiddleware<S extends AppStateI>(
    [DioMiddlewareOptions? options]) {
  final dio = Dio();
  return (Store<S> store, Dispatch next, Action action) {
    if (action.isProcessed || action.http == null) {
      return next(action);
    }
    _processHttpAction(options, store, action, dio);
  };
}
