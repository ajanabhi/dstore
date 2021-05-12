class OpenApi {
  final String? file;
  final OpenApiHttpConfig? http;

  const OpenApi({
    this.file,
    this.http,
  });
}

class OpenApiHttpConfig {
  final String url;
  final Map<String, String>? headers;
  final String? saveOnlineSpecToFile;

  const OpenApiHttpConfig(
      {required this.url, this.headers, this.saveOnlineSpecToFile});
}
