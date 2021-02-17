class PState {
  const PState();
}

class Selectors {
  const Selectors();
}

class AppStateAnnotation {
  const AppStateAnnotation();
}

class GraphqlApi {
  final String apiUrl;
  final String schemaPath;
  final String? wsUrl;
  const GraphqlApi(
      {required this.apiUrl, required this.schemaPath, String? this.wsUrl});
}

class GraphqlOps {
  final GraphqlApi api;
  const GraphqlOps(this.api);
}

class DImmutable {
  const DImmutable();
}
