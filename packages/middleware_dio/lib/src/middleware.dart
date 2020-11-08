import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:dstore/dstore.dart';

class _DioAbort extends AbortController {
  final CancelToken token;
  _DioAbort(this.token);
  @override
  void abort() {
    token.cancel();
  }
}

Options _getOptions(
    HttpPayload payload, DioMiddlewareOptions middlewareOptions) {
  final url = payload.url;
  GlobalHttpOptions go = null;
  if (middlewareOptions != null) {
    for (final me in middlewareOptions.urlOptions.entries) {
      if (url.startsWith(me.key)) {
        go = me.value();
      }
    }
  }
  String contentType;
  switch (payload.inputType) {
    case DSHttpInputType.JSON:
      contentType = Headers.jsonContentType;
      break;
    case DSHttpInputType.FORM:
      contentType = Headers.formUrlEncodedContentType;
      break;
    case DSHttpInputType.TEXT:
      contentType = "text/plain;charset=UTF-8";
  }
  final Map<String, dynamic> headers = {};
  if (go.headers != null) {
    headers.addAll(go.headers);
  }
  headers.addAll(payload.headers);
  return Options(
      contentType: contentType,
      headers: headers,
      sendTimeout: payload.sendTimeout,
      receiveTimeout: payload.receiveTieout);
}


_processHttpAction(DioMiddlewareOptions middlewareOptions, Store store,
    Action action, Dio dio) async {
  final payload = action.http;
  CancelToken cancelToken = null;
  if (payload.abortable) {
    cancelToken = CancelToken();
  }
  final options = _getOptions(payload, middlewareOptions);
  store.dispatch(action.copyWith());
  try {
    final response = await dio.request(payload.url,
        queryParameters: payload.queryParams,
        cancelToken: cancelToken,
        options: options);
  } on DioError catch (e) {}
}

class DioMiddlewareOptions {
  final Map<String, GlobalHttpOptions Function()> urlOptions;

  DioMiddlewareOptions({@required this.urlOptions});
}

Middleware<S> createDioMiddleware<S extends AppStateI>(
    [DioMiddlewareOptions options]) {
  final dio = Dio();
  return (Store<S> store, Dispatch next, Action action) {
    if (action.isProcessed || action.http == null) {
      return next(action);
    }
    _processHttpAction(options, store, action, dio);
  };
}
