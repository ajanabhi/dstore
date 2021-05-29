// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_http_ps.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class SimpleHttp extends PStateModel<SimpleHttp> {
  final helloPing ping;

  final helloJson json;

  final HelloOctet octet;

  final OptimisticFail optFail;

  @HttpRequestExtension(transformer: pingTransform)
  final helloJsonTransform<int> pinInt;

  @HttpRequestExtension(
      transformer: paginationTransformer, persitDataBetweenFetches: true)
  final Pagination pagination;

  final JsonPost jsPost;

  final FormUpload fromUpload;

  final UploadProgress uploadProgress;

  final DownloadProgress downloadProgress;

  final OfflineOp offlineOp;

  _$SimpleHttpCopyWith<SimpleHttp> get copyWith =>
      __$SimpleHttpCopyWithImpl<SimpleHttp>(this, IdentityFn);

  SimpleHttp(
      {this.ping = const helloPing(),
      this.json = const helloJson(),
      this.octet = const HelloOctet(),
      this.optFail = const OptimisticFail(),
      this.pinInt = const helloJsonTransform(),
      this.pagination = const Pagination(),
      this.jsPost = const JsonPost(),
      this.fromUpload = const FormUpload(),
      this.uploadProgress = const UploadProgress(),
      this.downloadProgress = const DownloadProgress(),
      this.offlineOp = const OfflineOp()});

  @override
  SimpleHttp copyWithMap(Map<String, dynamic> map) => SimpleHttp(
      ping: map.containsKey("ping") ? map["ping"] as helloPing : this.ping,
      json: map.containsKey("json") ? map["json"] as helloJson : this.json,
      octet: map.containsKey("octet") ? map["octet"] as HelloOctet : this.octet,
      optFail: map.containsKey("optFail")
          ? map["optFail"] as OptimisticFail
          : this.optFail,
      pinInt: map.containsKey("pinInt")
          ? map["pinInt"] as helloJsonTransform<int>
          : this.pinInt,
      pagination: map.containsKey("pagination")
          ? map["pagination"] as Pagination
          : this.pagination,
      jsPost:
          map.containsKey("jsPost") ? map["jsPost"] as JsonPost : this.jsPost,
      fromUpload: map.containsKey("fromUpload")
          ? map["fromUpload"] as FormUpload
          : this.fromUpload,
      uploadProgress: map.containsKey("uploadProgress")
          ? map["uploadProgress"] as UploadProgress
          : this.uploadProgress,
      downloadProgress: map.containsKey("downloadProgress")
          ? map["downloadProgress"] as DownloadProgress
          : this.downloadProgress,
      offlineOp: map.containsKey("offlineOp")
          ? map["offlineOp"] as OfflineOp
          : this.offlineOp);

  Map<String, dynamic> toMap() => <String, dynamic>{
        "ping": this.ping,
        "json": this.json,
        "octet": this.octet,
        "optFail": this.optFail,
        "pinInt": this.pinInt,
        "pagination": this.pagination,
        "jsPost": this.jsPost,
        "fromUpload": this.fromUpload,
        "uploadProgress": this.uploadProgress,
        "downloadProgress": this.downloadProgress,
        "offlineOp": this.offlineOp
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is SimpleHttp &&
        o.ping == ping &&
        o.json == json &&
        o.octet == octet &&
        o.optFail == optFail &&
        o.pinInt == pinInt &&
        o.pagination == pagination &&
        o.jsPost == jsPost &&
        o.fromUpload == fromUpload &&
        o.uploadProgress == uploadProgress &&
        o.downloadProgress == downloadProgress &&
        o.offlineOp == offlineOp;
  }

  @override
  int get hashCode =>
      ping.hashCode ^
      json.hashCode ^
      octet.hashCode ^
      optFail.hashCode ^
      pinInt.hashCode ^
      pagination.hashCode ^
      jsPost.hashCode ^
      fromUpload.hashCode ^
      uploadProgress.hashCode ^
      downloadProgress.hashCode ^
      offlineOp.hashCode;

  @override
  String toString() =>
      "SimpleHttp(ping: ${this.ping}, json: ${this.json}, octet: ${this.octet}, optFail: ${this.optFail}, pinInt: ${this.pinInt}, pagination: ${this.pagination}, jsPost: ${this.jsPost}, fromUpload: ${this.fromUpload}, uploadProgress: ${this.uploadProgress}, downloadProgress: ${this.downloadProgress}, offlineOp: ${this.offlineOp})";
}

abstract class $SimpleHttpCopyWith<O> {
  factory $SimpleHttpCopyWith(SimpleHttp value, O Function(SimpleHttp) then) =
      _$SimpleHttpCopyWithImpl<O>;
  O call(
      {helloPing ping,
      helloJson json,
      HelloOctet octet,
      OptimisticFail optFail,
      helloJsonTransform<int> pinInt,
      Pagination pagination,
      JsonPost jsPost,
      FormUpload fromUpload,
      UploadProgress uploadProgress,
      DownloadProgress downloadProgress,
      OfflineOp offlineOp});
}

class _$SimpleHttpCopyWithImpl<O> implements $SimpleHttpCopyWith<O> {
  final SimpleHttp _value;
  final O Function(SimpleHttp) _then;
  _$SimpleHttpCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? ping = dimmutable,
      Object? json = dimmutable,
      Object? octet = dimmutable,
      Object? optFail = dimmutable,
      Object? pinInt = dimmutable,
      Object? pagination = dimmutable,
      Object? jsPost = dimmutable,
      Object? fromUpload = dimmutable,
      Object? uploadProgress = dimmutable,
      Object? downloadProgress = dimmutable,
      Object? offlineOp = dimmutable}) {
    return _then(_value.copyWith(
        ping: ping == dimmutable ? _value.ping : ping as helloPing,
        json: json == dimmutable ? _value.json : json as helloJson,
        octet: octet == dimmutable ? _value.octet : octet as HelloOctet,
        optFail:
            optFail == dimmutable ? _value.optFail : optFail as OptimisticFail,
        pinInt: pinInt == dimmutable
            ? _value.pinInt
            : pinInt as helloJsonTransform<int>,
        pagination: pagination == dimmutable
            ? _value.pagination
            : pagination as Pagination,
        jsPost: jsPost == dimmutable ? _value.jsPost : jsPost as JsonPost,
        fromUpload: fromUpload == dimmutable
            ? _value.fromUpload
            : fromUpload as FormUpload,
        uploadProgress: uploadProgress == dimmutable
            ? _value.uploadProgress
            : uploadProgress as UploadProgress,
        downloadProgress: downloadProgress == dimmutable
            ? _value.downloadProgress
            : downloadProgress as DownloadProgress,
        offlineOp: offlineOp == dimmutable
            ? _value.offlineOp
            : offlineOp as OfflineOp));
  }
}

abstract class _$SimpleHttpCopyWith<O> implements $SimpleHttpCopyWith<O> {
  factory _$SimpleHttpCopyWith(SimpleHttp value, O Function(SimpleHttp) then) =
      __$SimpleHttpCopyWithImpl<O>;
  O call(
      {helloPing ping,
      helloJson json,
      HelloOctet octet,
      OptimisticFail optFail,
      helloJsonTransform<int> pinInt,
      Pagination pagination,
      JsonPost jsPost,
      FormUpload fromUpload,
      UploadProgress uploadProgress,
      DownloadProgress downloadProgress,
      OfflineOp offlineOp});
}

class __$SimpleHttpCopyWithImpl<O> extends _$SimpleHttpCopyWithImpl<O>
    implements _$SimpleHttpCopyWith<O> {
  __$SimpleHttpCopyWithImpl(SimpleHttp _value, O Function(SimpleHttp) _then)
      : super(_value, (v) => _then(v));

  @override
  SimpleHttp get _value => super._value;

  @override
  O call(
      {Object? ping = dimmutable,
      Object? json = dimmutable,
      Object? octet = dimmutable,
      Object? optFail = dimmutable,
      Object? pinInt = dimmutable,
      Object? pagination = dimmutable,
      Object? jsPost = dimmutable,
      Object? fromUpload = dimmutable,
      Object? uploadProgress = dimmutable,
      Object? downloadProgress = dimmutable,
      Object? offlineOp = dimmutable}) {
    return _then(SimpleHttp(
        ping: ping == dimmutable ? _value.ping : ping as helloPing,
        json: json == dimmutable ? _value.json : json as helloJson,
        octet: octet == dimmutable ? _value.octet : octet as HelloOctet,
        optFail:
            optFail == dimmutable ? _value.optFail : optFail as OptimisticFail,
        pinInt: pinInt == dimmutable
            ? _value.pinInt
            : pinInt as helloJsonTransform<int>,
        pagination: pagination == dimmutable
            ? _value.pagination
            : pagination as Pagination,
        jsPost: jsPost == dimmutable ? _value.jsPost : jsPost as JsonPost,
        fromUpload: fromUpload == dimmutable
            ? _value.fromUpload
            : fromUpload as FormUpload,
        uploadProgress: uploadProgress == dimmutable
            ? _value.uploadProgress
            : uploadProgress as UploadProgress,
        downloadProgress: downloadProgress == dimmutable
            ? _value.downloadProgress
            : downloadProgress as DownloadProgress,
        offlineOp: offlineOp == dimmutable
            ? _value.offlineOp
            : offlineOp as OfflineOp));
  }
}

const _SimpleHttp_FullPath = "/store/pstates/http/simple_http_ps/SimpleHttp";

abstract class SimpleHttpActions {
  static Action<HttpField<Null, String, String>> ping(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      String? optimisticResponse,
      HttpField<Null, String, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, String, String>>(
        name: "ping",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, String, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/",
            method: "GET",
            responseType: HttpResponseType.STRING,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, String, String>> pingMock(
      HttpField<Null, String, String> mock) {
    return Action<HttpField<Null, String, String>>(
        name: "ping", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, helloJsonResponse, String>> json(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      helloJsonResponse? optimisticResponse,
      HttpField<Null, helloJsonResponse, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, helloJsonResponse, String>>(
        name: "json",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, helloJsonResponse, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/json",
            method: "GET",
            responseType: HttpResponseType.JSON,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, helloJsonResponse, String>> jsonMock(
      HttpField<Null, helloJsonResponse, String> mock) {
    return Action<HttpField<Null, helloJsonResponse, String>>(
        name: "json", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, List<int>, String>> octet(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      List<int>? optimisticResponse,
      HttpField<Null, List<int>, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, List<int>, String>>(
        name: "octet",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, List<int>, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/octet",
            method: "GET",
            responseType: HttpResponseType.BYTES,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, List<int>, String>> octetMock(
      HttpField<Null, List<int>, String> mock) {
    return Action<HttpField<Null, List<int>, String>>(
        name: "octet", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, String, String>> optFail(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      String? optimisticResponse,
      HttpField<Null, String, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, String, String>>(
        name: "optFail",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, String, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/optimistic-fail",
            method: "GET",
            responseType: HttpResponseType.STRING,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, String, String>> optFailMock(
      HttpField<Null, String, String> mock) {
    return Action<HttpField<Null, String, String>>(
        name: "optFail", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, int, String>> pinInt(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      helloJsonResponse? optimisticResponse,
      HttpField<Null, int, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, int, String>>(
        name: "pinInt",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, helloJsonResponse, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/json",
            method: "GET",
            responseType: HttpResponseType.JSON,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, int, String>> pinIntMock(
      HttpField<Null, int, String> mock) {
    return Action<HttpField<Null, int, String>>(
        name: "pinInt", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, PaginationResponse, String>> pagination(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      PaginationResponse? optimisticResponse,
      required PaginationPathParams pathParams,
      required PaginationQueryParams queryParams,
      HttpField<Null, PaginationResponse, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, PaginationResponse, String>>(
        name: "pagination",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<PaginationPathParams, PaginationQueryParams, Null,
                PaginationResponse, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/pagination/{page}",
            method: "GET",
            responseType: HttpResponseType.JSON,
            pathParams: pathParams,
            queryParams: queryParams,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, PaginationResponse, String>> paginationMock(
      HttpField<Null, PaginationResponse, String> mock) {
    return Action<HttpField<Null, PaginationResponse, String>>(
        name: "pagination", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<JsonPostRequestBody, JsonPostResponse, String>>
      jsPost(
          {required JsonPostRequestBody input,
          bool abortable = false,
          bool silent = false,
          bool offline = false,
          Map<String, dynamic>? headers,
          JsonPostResponse? optimisticResponse,
          HttpField<JsonPostRequestBody, JsonPostResponse, String>? mock,
          Duration? debounce,
          bool listenSendProgress = false,
          bool listenReceiveProgress = false}) {
    return Action<HttpField<JsonPostRequestBody, JsonPostResponse, String>>(
        name: "jsPost",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, JsonPostRequestBody, JsonPostResponse,
                String, dynamic>(
            data: input,
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/jsonpost",
            method: "POST",
            responseType: HttpResponseType.JSON,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<JsonPostRequestBody, JsonPostResponse, String>>
      jsPostMock(
          HttpField<JsonPostRequestBody, JsonPostResponse, String> mock) {
    return Action<HttpField<JsonPostRequestBody, JsonPostResponse, String>>(
        name: "jsPost", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<FormUploadRequestBody, FormUploadResponse, String>>
      fromUpload(
          {required FormUploadRequestBody input,
          bool abortable = false,
          bool silent = false,
          bool offline = false,
          Map<String, dynamic>? headers,
          FormUploadResponse? optimisticResponse,
          HttpField<FormUploadRequestBody, FormUploadResponse, String>? mock,
          Duration? debounce,
          bool listenSendProgress = false,
          bool listenReceiveProgress = false}) {
    return Action<HttpField<FormUploadRequestBody, FormUploadResponse, String>>(
        name: "fromUpload",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, FormUploadRequestBody, FormUploadResponse,
                String, dynamic>(
            data: input,
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/form-upload",
            method: "POST",
            responseType: HttpResponseType.JSON,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<FormUploadRequestBody, FormUploadResponse, String>>
      fromUploadMock(
          HttpField<FormUploadRequestBody, FormUploadResponse, String> mock) {
    return Action<HttpField<FormUploadRequestBody, FormUploadResponse, String>>(
        name: "fromUpload", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<List<int>, UploadProgressResponse, String>>
      uploadProgress(
          {required List<int> input,
          bool abortable = false,
          bool silent = false,
          bool offline = false,
          Map<String, dynamic>? headers,
          UploadProgressResponse? optimisticResponse,
          HttpField<List<int>, UploadProgressResponse, String>? mock,
          Duration? debounce,
          bool listenSendProgress = false,
          bool listenReceiveProgress = false}) {
    return Action<HttpField<List<int>, UploadProgressResponse, String>>(
        name: "uploadProgress",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, List<int>, UploadProgressResponse, String,
                dynamic>(
            data: input,
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/uploadprogress",
            method: "POST",
            responseType: HttpResponseType.JSON,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<List<int>, UploadProgressResponse, String>>
      uploadProgressMock(
          HttpField<List<int>, UploadProgressResponse, String> mock) {
    return Action<HttpField<List<int>, UploadProgressResponse, String>>(
        name: "uploadProgress", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, List<int>, String>> downloadProgress(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      List<int>? optimisticResponse,
      HttpField<Null, List<int>, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, List<int>, String>>(
        name: "downloadProgress",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, List<int>, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/download",
            method: "POST",
            responseType: HttpResponseType.BYTES,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, List<int>, String>> downloadProgressMock(
      HttpField<Null, List<int>, String> mock) {
    return Action<HttpField<Null, List<int>, String>>(
        name: "downloadProgress", type: _SimpleHttp_FullPath, mock: mock);
  }

  static Action<HttpField<Null, String, String>> offlineOp(
      {bool abortable = false,
      bool silent = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      String? optimisticResponse,
      HttpField<Null, String, String>? mock,
      Duration? debounce,
      bool listenSendProgress = false,
      bool listenReceiveProgress = false}) {
    return Action<HttpField<Null, String, String>>(
        name: "offlineOp",
        type: _SimpleHttp_FullPath,
        silent: silent,
        http: HttpPayload<Null, Null, Null, String, String, dynamic>(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "http://localhost:8080/offline",
            method: "GET",
            responseType: HttpResponseType.STRING,
            listenSendProgress: listenSendProgress,
            listenReceiveProgress: listenReceiveProgress),
        debounce: debounce);
  }

  static Action<HttpField<Null, String, String>> offlineOpMock(
      HttpField<Null, String, String> mock) {
    return Action<HttpField<Null, String, String>>(
        name: "offlineOp", type: _SimpleHttp_FullPath, mock: mock);
  }
}

SimpleHttp SimpleHttp_DS() => SimpleHttp(
    ping: helloPing(),
    json: helloJson(),
    octet: HelloOctet(),
    optFail: OptimisticFail(),
    pinInt: helloJsonTransform(),
    pagination: Pagination(),
    jsPost: JsonPost(),
    fromUpload: FormUpload(),
    uploadProgress: UploadProgress(),
    downloadProgress: DownloadProgress(),
    offlineOp: OfflineOp());

final SimpleHttpMeta = PStateMeta<
    SimpleHttp>(type: _SimpleHttp_FullPath, ds: SimpleHttp_DS, httpMetaMap: {
  "ping": HttpMeta<Null, Null, Null, String, String, String>(
      responseSerializer: helloPingResponse_SuccessSerializer,
      responseDeserializer: helloPingResponse_SuccessDeserializer),
  "json":
      HttpMeta<Null, Null, Null, helloJsonResponse, String, helloJsonResponse>(
          responseSerializer: helloJsonResponse.toJsonStatic,
          responseDeserializer: helloJsonResponse.fromJsonStatic),
  "octet": HttpMeta<Null, Null, Null, List<int>, String, List<int>>(
      responseSerializer: HelloOctetResponse_SuccessSerializer,
      responseDeserializer: HelloOctetResponse_SuccessDeserializer),
  "optFail": HttpMeta<Null, Null, Null, String, String, String>(
      responseSerializer: OptimisticFailResponse_SuccessSerializer,
      responseDeserializer: OptimisticFailResponse_SuccessDeserializer),
  "pinInt": HttpMeta<Null, Null, Null, helloJsonResponse, String, int>(
      responseSerializer: helloJsonResponse.toJsonStatic,
      transformer: pingTransform,
      responseDeserializer: helloJsonResponse.fromJsonStatic),
  "pagination": HttpMeta<PaginationPathParams, PaginationQueryParams, Null,
          PaginationResponse, String, PaginationResponse>(
      queryParamsSerializer: PaginationQueryParams.toJsonStatic,
      queryParamsDeserializer: PaginationQueryParams.fromJsonStatic,
      pathParamsSerializer: PaginationPathParams.toJsonStatic,
      pathParamsDeserializer: PaginationPathParams.fromJsonStatic,
      responseSerializer: PaginationResponse.toJsonStatic,
      persitDataBetweenFetches: true,
      transformer: paginationTransformer,
      responseDeserializer: PaginationResponse.fromJsonStatic),
  "jsPost": HttpMeta<Null, Null, JsonPostRequestBody, JsonPostResponse, String,
          JsonPostResponse>(
      inputSerializer: JsonPostRequestBodySerializer,
      inputDeserializer: JsonPostRequestBodyDeserializer,
      responseSerializer: JsonPostResponse.toJsonStatic,
      responseDeserializer: JsonPostResponse.fromJsonStatic),
  "fromUpload": HttpMeta<Null, Null, FormUploadRequestBody, FormUploadResponse,
          String, FormUploadResponse>(
      inputSerializer: FormUploadRequestBodySerializer,
      inputDeserializer: FormUploadRequestBodyDeserializer,
      responseSerializer: FormUploadResponse.toJsonStatic,
      responseDeserializer: FormUploadResponse.fromJsonStatic),
  "uploadProgress": HttpMeta<Null, Null, List<int>, UploadProgressResponse,
          String, UploadProgressResponse>(
      inputSerializer: UploadProgressRequestBodySerializer,
      inputDeserializer: UploadProgressRequestBodyDeserializer,
      responseSerializer: UploadProgressResponse.toJsonStatic,
      responseDeserializer: UploadProgressResponse.fromJsonStatic),
  "downloadProgress": HttpMeta<Null, Null, Null, List<int>, String, List<int>>(
      responseSerializer: DownloadProgressResponse_SuccessSerializer,
      responseDeserializer: DownloadProgressResponse_SuccessDeserializer),
  "offlineOp": HttpMeta<Null, Null, Null, String, String, String>(
      responseSerializer: OfflineOpResponse_SuccessSerializer,
      responseDeserializer: OfflineOpResponse_SuccessDeserializer)
});
