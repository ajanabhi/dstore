class PState {
  final bool persist;
  const PState({this.persist = false});
}

class Selectors {
  const Selectors();
}

class AppStateAnnotation {
  const AppStateAnnotation();
}

class GraphqlApi {
  final String apiUrl;
  final String? schemaPath;
  final String? wsUrl;
  const GraphqlApi({required this.apiUrl, this.schemaPath, this.wsUrl});
}

class GraphqlOps {
  final GraphqlApi api;
  const GraphqlOps(this.api);
}

class DImmutable {
  const DImmutable();
}

const dimmutable = DImmutable();

class PersistKey {
  final bool ignore;
  const PersistKey({this.ignore = false});
}
