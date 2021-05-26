import 'dart:convert';

import 'package:dio/dio.dart';
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
    if (greq.extensions != null &&
        greq.useGetForPersitent &&
        greq.variables == null) {
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
    case DioErrorType.connectTimeout:
      error = HttpError(type: HttpErrorType.ConnectTimeout, message: e.message);
      break;
    case DioErrorType.sendTimeout:
      error = HttpError(type: HttpErrorType.SendTimeout, message: e.message);
      break;
    case DioErrorType.receiveTimeout:
      error = HttpError(type: HttpErrorType.ReceiveTimeout, message: e.message);
      break;
    case DioErrorType.response:
      var re = e.response!;
      if (meta?.errorDeserializer != null) {
        re = meta?.errorDeserializer!(re.statusCode ?? 500, re.data);
      }
      error = HttpError(type: HttpErrorType.Response, error: re);
      break;
    case DioErrorType.cancel:
      error = HttpError(type: HttpErrorType.Aborted, message: e.message);
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

String _getUrlFromPayload({required Action action, required HttpMeta? meta}) {
  final payload = action.http!;
  var result = payload.url;
  final queryParams = payload.queryParams;
  final pathParams = payload.pathParams;
  if (queryParams != null || pathParams != null) {
    if (pathParams != null) {
      if (meta?.pathParamsSerializer == null) {
        throw ArgumentError.value(
            "pathParamsSerializer is missing in HttpMeta for action :  ${action.id}");
      }
      final pp =
          meta!.pathParamsSerializer!(pathParams) as Map<String, dynamic>;
      pp.forEach((key, value) {
        result = result.replaceFirst('{${key}}', value.toString());
      });
    }
    if (queryParams != null) {
      if (meta?.queryParamsSerializer == null) {
        throw ArgumentError.value(
            "queryParamsSerializer is missing in HttpMeta for action :  ${action.id}");
      }
      final qp =
          meta!.queryParamsSerializer!(queryParams) as Map<String, dynamic>;
      result = Uri(path: result, queryParameters: qp).toString();
    }
  }
  return result;
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
    var url = _getUrlFromPayload(action: action, meta: meta);
    var data = payload.data;
    if (meta?.inputSerializer != null) {
      data = meta?.inputSerializer!(data);
    }
    if (payload.data is GraphqlRequestInput) {
      final greq = payload.data as GraphqlRequestInput;
      if (greq.extensions != null) {
        if (greq.useGetForPersitent && greq.variables == null) {
          url = "$url?extensions=${jsonEncode(greq.extensions)}";
          data = null;
        } else {
          data = data as Map<String, dynamic>;
          data.remove("query");
          data.remove("useGetForPersitent");
        }
      }
    }
    dynamic onReceiveProgress;
    if (payload.listenReceiveProgress) {
      onReceiveProgress = (int got, int total) {
        store.dispatch(action.copyWith(
            internal: ActionInternal(
                processed: true,
                type: ActionInternalType.FIELD,
                data: field.copyWith(
                    progress: HttpProgress(current: got, total: total)))));
      };
    }
    dynamic onSendProgress;
    if (payload.listenSendProgress) {
      onSendProgress = (int sent, int total) {
        store.dispatch(action.copyWith(
            internal: ActionInternal(
                processed: true,
                type: ActionInternalType.FIELD,
                data: field.copyWith(
                    progress: HttpProgress(current: sent, total: total)))));
      };
    }
    response = await dio.request(payload.url,
        data: data,
        queryParameters: payload.queryParams,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: options);
  } on DioError catch (e) {
    _handleDioError(e: e, action: action, store: store);
  } catch (e) {
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
              payload: payload, options: options, meta: meta);
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
      var data =
          meta!.responseDeserializer(response.statusCode ?? 200, response.data);
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
    if (action.isProcessed) {
      return next(action);
    }
    dynamic mock = store.internalMocksMap[action.id]?.mock;
    if (mock != null) {
      // final mock
      mock = mock as HttpField;
      return store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, data: mock, type: ActionInternalType.FIELD)));
    }
    if (action.http == null) {
      return next(action);
    }

    DstoreDevUtils.handleUnCaughtError(
        store: store,
        action: action,
        callback: () => _processHttpAction(options, store, action, dio));
  };
}

Future<Response> createPersistedGraphqlQuery(
    {required HttpPayload payload,
    required Options options,
    required HttpMeta? meta}) async {
  final req = payload.data as GraphqlRequestInput;
  var url = payload.url;
  var data;
  if (req.variables == null) {
    url =
        '${payload.url}?query=${req.query}&extensions=${jsonEncode(req.extensions)}';
  } else {
    data = meta?.inputSerializer!(req);
  }

  final dio = Dio();
  final resp = await dio.request(url, options: options, data: data);
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
