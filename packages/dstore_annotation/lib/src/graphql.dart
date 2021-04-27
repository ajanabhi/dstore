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

enum GraphqlDatabase { dgraph }

typedef SchemaUploadFn = Future<String> Function(String schema);

class GraphqlSchema {
  final String path;
  final GraphqlDatabase database;
  final SchemaUploadRequest? schemaUplodDetails;
  final bool uploadSchema;
  const GraphqlSchema(
      {required this.path,
      required this.database,
      this.schemaUplodDetails,
      this.uploadSchema = false});
}

class SchemaUploadRequest {
  final String url;
  final Map<String, String>? headers;

  const SchemaUploadRequest({required this.url, this.headers});
}

abstract class GraphqlSchemaI {
  Type? interfaces;
  dynamic? objects;
  Type? unions;
  Type? directives;
  Type? query;
  Type? mutation;
  Type? subscription;
}

class ID {}
