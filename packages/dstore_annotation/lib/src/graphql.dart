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

enum Database { dgraph }

typedef SchemaUploadFn = Future<String> Function();

class GraphqlSource {
  final String path;
  final Database? database;
  final SchemaUploadFn? schemaUplodFn;
  final bool uploadSchema;
  const GraphqlSource(
      {required this.path,
      this.database,
      this.schemaUplodFn,
      this.uploadSchema = false});
}

abstract class GraphqlSourceI {
  Type? interfaces;
  Type? objects;
  Type? unions;
  Type? directives;
  Type? query;
  Type? mutation;
  Type? subscription;
}

class ID {}
