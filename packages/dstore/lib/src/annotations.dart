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
  const GraphqlApi(
      {required String apiUrl, required String schemaPath, String? wsUrl});
}

class GraphqlOps {
  const GraphqlOps(GraphqlApi api);
}
