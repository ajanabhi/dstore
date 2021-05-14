class OpenApi {
  final String? file;
  final OpenApiHttpConfig? http;

  final String? revison; // temp variable to trigger schema gen
  const OpenApi({this.file, this.http, this.revison});
}

class OpenApiHttpConfig {
  final String url;
  final Map<String, String>? headers;
  final String? saveOnlineSpecToFile;

  const OpenApiHttpConfig(
      {required this.url, this.headers, this.saveOnlineSpecToFile});
}
