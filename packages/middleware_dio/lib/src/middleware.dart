import 'dart:convert';

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
  var method = payload.method;
  if (payload.data is GraphqlRequestInput) {
    final greq = payload.data as GraphqlRequestInput;
    if (greq.extensions != null && greq.useGetForPersitent) {
      method = "GET";
    }
  }
  return Options(
      method: method,
      headers: headers,
      responseType: responseType,
      sendTimeout: payload.sendTimeout,
      receiveTimeout: payload.receiveTieout);
}

void _handleDioError(
    {required DioError e, required Action action, required Store store}) {
  final psm = store.getPStateMetaFromAction(action);
  final payload = action.http!;
  final meta = psm.httpMetaMap?[action.name];
  final field = store.getFieldFromAction(action) as HttpField;
  late HttpError error;
  switch (e.type) {
    case DioErrorType.CONNECT_TIMEOUT:
      error = HttpError(type: HttpErrorType.ConnectTimeout, message: e.message);
      break;
    case DioErrorType.SEND_TIMEOUT:
      error = HttpError(type: HttpErrorType.SendTimeout, message: e.message);
      break;
    case DioErrorType.RECEIVE_TIMEOUT:
      error = HttpError(type: HttpErrorType.ReceiveTimeout, message: e.message);
      break;
    case DioErrorType.RESPONSE:
      var re = e.response;
      if (meta?.errorDeserializer != null) {
        re = meta?.errorDeserializer!(re.statusCode, re.data);
      }
      error = HttpError(type: HttpErrorType.Response, error: re);
      break;
    case DioErrorType.CANCEL:
      error = HttpError(type: HttpErrorType.Aborted, message: e.message);
      break;
    case DioErrorType.DEFAULT:
      error = HttpError(type: HttpErrorType.Default, message: e.message);
      break;
    default:
      error = HttpError(type: HttpErrorType.Default, message: e.message);
      break;
  }
  if (payload.offline &&
      (error.type == HttpErrorType.Default ||
          error.type == HttpErrorType.ConnectTimeout)) {
    store.addOfflineAction(action);
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.FIELD,
            data: field.copyWith(loading: false, offline: true))));
  } else {
    var ef = HttpField(error: error);
    if (meta?.transformer != null) {
      ef = meta?.transformer!(field, ef) as dynamic;
    }
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true, type: ActionInternalType.FIELD, data: ef)));
  }
}

void _processHttpAction(DioMiddlewareOptions? middlewareOptions, Store store,
    Action action, Dio dio) async {
  final psm = store.getPStateMetaFromAction(action);
  final payload = action.http!;
  final meta = psm.httpMetaMap?[action.name];
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
            type: ActionInternalType.FIELD,
            data: HttpField(
                data: payload.optimisticResponse,
                abortController: abortController,
                optimistic: true))));
  } else {
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.FIELD,
            data: HttpField(loading: true, abortController: abortController))));
  }
  late final Response? response;
  try {
    var url = payload.url;
    var data = payload.data;
    if (meta?.inputSerializer != null) {
      data = meta?.inputSerializer!(data);
    }
    if (payload.data is GraphqlRequestInput) {
      final greq = payload.data as GraphqlRequestInput;
      if (greq.extensions != null) {
        if (greq.useGetForPersitent) {
          url = "$url?extensions=${jsonEncode(greq.extensions)}";
          data = null;
        } else {
          data = data as Map<String, dynamic>;
          data.remove("query");
          data.remove("useGetForPersitent");
        }
      }
    }
    response = await dio.request(payload.url,
        data: data,
        queryParameters: payload.queryParams,
        cancelToken: cancelToken,
        options: options);
  } on DioError catch (e) {} catch (e) {
    rethrow;
  }
  void handleGraphqlResponse(Response response) {
    late HttpField hf;
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
      rdata = meta!.responseDeserializer(200, response.data["data"]);
    }
    hf = HttpField(error: ge, data: rdata);
    if (meta?.transformer != null) {
      hf = meta!.transformer!(field, hf);
    }
    store.dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true, type: ActionInternalType.FIELD, data: hf)));
  }

  if (response != null) {
    if (payload.data is GraphqlRequestInput) {
      // graphql request
      if (isPersistQueryNotFoundError(response)) {
        try {
          final presp = await createPersistedGraphqlQuery(
              payload: payload, options: options);
          handleGraphqlResponse(presp);
        } on DioError catch (e) {
          _handleDioError(e: e, action: action, store: store);
        } catch (e) {
          rethrow;
        }
      } else {
        handleGraphqlResponse(response);
      }
    } else {
      late HttpField hf;
      var data = meta!.responseDeserializer(response.statusCode, response.data);
      hf = HttpField(data: data);
      if (meta.transformer != null) {
        hf = meta.transformer!(field, hf);
      }
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, type: ActionInternalType.FIELD, data: hf)));
    }
  }
}

class DioMiddlewareOptions {
  final Map<String, GlobalHttpOptions Function()> urlOptions;

  DioMiddlewareOptions({required this.urlOptions});
}

dynamic createDioMiddleware<S extends AppStateI<S>>(
    [DioMiddlewareOptions? options]) {
  final dio = Dio();
  return (Store<S> store, Dispatch next, Action action) {
    if (action.isProcessed || action.http == null) {
      return next(action);
    }
    _processHttpAction(options, store, action, dio);
  };
}

Future<Response> createPersistedGraphqlQuery(
    {required HttpPayload payload, required Options options}) async {
  final req = payload.data as GraphqlRequestInput;
  final url =
      '${payload.url}?query=${req.query}&extensions=${jsonEncode(req.extensions)}';
  final dio = Dio();
  final resp = await dio.get(url, options: Options(headers: payload.headers));
  return resp;
}

bool isPersistQueryNotFoundError(Response response) {
  var result = false;
  final data = response.data as Map<String, dynamic>?;
  if (data != null && data["errors"] != null) {
    final errors = data["errors"] as List<dynamic>;
    result = errors
        .map((e) => GraphqlError.fromJson(e))
        .where((e) => e.message == "PersistedQueryNotFound")
        .isNotEmpty;
  }
  return result;
}
