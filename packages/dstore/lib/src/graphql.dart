class GraphqlRequestInput<V> {
  final String query;
  final V? variables;

  GraphqlRequestInput(this.query, this.variables);

  static Map<String, dynamic> toJson<V>(GraphqlRequestInput<V> req) {
    return <String, dynamic>{
      "query": req.query,
      "variables":
          req.variables != null ? (req.variables as dynamic).toJson() : null
    };
  }
}

class SourceLocation {
  final int line;
  final int column;

  SourceLocation({required this.line, required this.column});

  factory SourceLocation.fromJson(Map<String, dynamic> json) =>
      SourceLocation(line: json["line"] as int, column: json["column"] as int);
}

class GraphqlError {
  final String message;
  final List<SourceLocation>? locations;
  final dynamic? originalError;
  final Map<String, dynamic>? extensions;
  final List<int>? positions;
  final dynamic? source;
  final List<String>? path;

  GraphqlError(
      {required this.message,
      this.locations,
      this.originalError,
      this.extensions,
      this.positions,
      this.source,
      this.path});

  factory GraphqlError.fromJson(Map<String, dynamic> json) {
    return GraphqlError(
      message: json['message'] as String,
      locations: (json["locations"] as List<Map<String, dynamic>>?)
          ?.map((e) => SourceLocation.fromJson(e))
          .toList(),
      originalError: json["originalError"],
      extensions: json["extensions"] as Map<String, dynamic>?,
      source: json["source"],
      positions: (json["positions"] as List<int>?)?.map((e) => e).toList(),
      path: (json["path"] as List<String>?)?.map((e) => e).toList(),
    );
  }
}
