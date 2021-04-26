class GraphqlApi {
  final String apiUrl;
  final String? schemaPath;
  final String? wsUrl;
  final Map<String, String>? scalarMap;
  const GraphqlApi(
      {required this.apiUrl, this.schemaPath, this.wsUrl, this.scalarMap});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GraphqlApi && other.apiUrl == apiUrl;
  }

  @override
  int get hashCode {
    return apiUrl.hashCode;
  }
}

class GraphqlOps {
  final GraphqlApi api;
  const GraphqlOps(this.api);
}

class GraphqlSource {
  final String path;
  const GraphqlSource({required this.path});
}

abstract class GraphqlSourceI {
  List<Type>? interfaces;
  List<Type>? objects;
  List<Type>? unions;
  List<Type>? directives;
  Type? query;
  Type? mutation;
  Type? subscription;
}
