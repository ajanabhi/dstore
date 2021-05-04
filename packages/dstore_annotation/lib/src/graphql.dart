class GraphqlApi {
  final String apiUrl;
  final String? schemaPath;
  final String? cacheOnlineApiSchema;
  final String? wsUrl;
  final Map<String, String>? scalarMap;
  final PersitantQueryMode? enablePersitantQueries;
  const GraphqlApi(
      {required this.apiUrl,
      this.cacheOnlineApiSchema,
      this.schemaPath,
      this.wsUrl,
      this.enablePersitantQueries,
      this.scalarMap});

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

enum PersitantQueryMode { GET, POST }

class GraphqlOps {
  final GraphqlApi api;
  const GraphqlOps(this.api);
}

enum GraphqlDatabase { dgraph }

typedef SchemaUploadFn = Future<String> Function(String schema);

class GraphqlSchemaSource {
  final String path;
  final String? lambdaSourceFile;
  final GraphqlDatabase database;
  final SchemaUploadRequest? schemaUplodDetails;
  final bool uploadSchema;
  final bool uploadLambda;
  final String? comments;
  const GraphqlSchemaSource(
      {required this.path,
      required this.database,
      this.schemaUplodDetails,
      this.comments,
      this.uploadLambda = false,
      this.lambdaSourceFile,
      this.uploadSchema = false});
}

class SchemaUploadRequest {
  final String url;
  final Map<String, String>? headers;

  const SchemaUploadRequest({required this.url, this.headers});
}

class ID {}
