import 'dart:convert';

class hasInverse {
  final String field;

  const hasInverse(this.field);

  @override
  String toString() => "hasInverse(field: ${field})";
}

enum DgraphIndex {
  int,
  int64,
  float,
  bool,
  hash,
  exact,
  term,
  fulltext,
  trigram,
  regexp,
  year,
  month,
  day,
  hour,
  geo
}

class search {
  final List<DgraphIndex>? by;

  const search(this.by);

  @override
  String toString() {
    final bys = by != null
        ? "(by: [${by!.map((e) => e.toString().split(".").last).join(", ")}])"
        : "";
    return "@search$bys";
  }
}

class id {
  const id();
  @override
  String toString() => "@id";
}

class dgraph {
  final String? type;
  final String? pred;

  const dgraph({this.type, this.pred});

  @override
  String toString() {
    final params = <String>[];
    if (type != null) {
      params.add("type: \"${type}\"");
    }
    if (pred != null) {
      params.add("pred: \"${pred}\"");
    }
    return "@dgraph(${params.join(", ")})";
  }
}

class withSubscription {
  const withSubscription();
  @override
  String toString() => "@withSubscription";
}

class secret {
  final String field;
  final String? pred;

  secret({required this.field, this.pred});

  @override
  String toString() {
    final params = <String>["field: \"$field\""];
    if (pred != null) {
      params.add("pred: \"$pred\"");
    }
    return "@secret(${params.join(", ")})";
  }
}

class AuthRule {
  final List<AuthRule>? and;
  final List<AuthRule>? or;
  final AuthRule? not;
  final String? rule;

  const AuthRule({this.and, this.or, this.not, this.rule});

  @override
  String toString() {
    final params = <String>[];
    if (rule != null) {
      params.add("rule: \"\"\" $rule \"\"\"");
    }
    if (not != null) {
      params.add("not: ${not}");
    }
    if (and != null) {
      params.add("and: ${and!.map((e) => e.toString()).toList()}");
    }
    if (or != null) {
      params.add("or: ${or!.map((e) => e.toString()).toList()}");
    }
    return '{${params.join(", ")}}';
  }
}

class auth {
  final AuthRule? query;
  final AuthRule? add;
  final AuthRule? update;
  final AuthRule? delete;

  const auth({this.query, this.add, this.update, this.delete});

  @override
  String toString() {
    final params = <String>[];
    return 'auth(query: $query, add: $add, update: $update, delete: $delete)';
  }
}

enum HTTPMethod { GET, POST, PUT, PATCH, DELETE }

enum Mode { BATCH, SINGLE }

class CustomHTTP {
  final String url;
  final HTTPMethod method;
  final String? body;
  final String? graphql;
  final Mode? mode;
  final List<String>? forwardHeaders;
  final List<String>? secretHeaders;
  final List<String>? introspectionHeaders;
  final bool? skipIntrospection;

  const CustomHTTP(
      {required this.url,
      required this.method,
      this.body,
      this.graphql,
      this.mode,
      this.forwardHeaders,
      this.secretHeaders,
      this.introspectionHeaders,
      this.skipIntrospection});
}

class custom {
  final CustomHTTP? http;
  final String? dql;

  const custom({this.http, this.dql});

  @override
  String toString() {
    final params = <String>[];
    if (dql != null) {
      params.add("dql: ${dql}");
    }
    if (this.http != null) {
      final http = this.http!;
      final cParams = <String>[];
      cParams.add("url: \"${http.url}\"");
      cParams.add("method: ${http.method.toString().split(".").last}");
      if (http.introspectionHeaders != null) {
        cParams.add(
            "introspectionHeaders: ${jsonEncode(http.introspectionHeaders)}");
      }
      if (http.secretHeaders != null) {
        cParams.add("secretHeaders: ${jsonEncode(http.secretHeaders)}");
      }
      if (http.forwardHeaders != null) {
        cParams.add("forwardHeaders: ${jsonEncode(http.forwardHeaders)}");
      }
      if (http.graphql != null) {
        cParams.add("graphql: \"\"\"${http.graphql}\"\"\"");
      }

      if (http.skipIntrospection != null) {
        cParams.add("skipIntrospection: ${http.skipIntrospection}");
      }

      if (http.mode != null) {
        cParams.add("mode: ${http.mode.toString().split(".").last}");
      }

      params.add("http: {${cParams.join(", ")}}");
    }
    return "@custom(${params.join(", ")})";
  }
}

class remote {
  const remote();
  @override
  String toString() => "@remote";
}

class lambda {
  const lambda();
  @override
  String toString() => "@lambda";
}

class cascade {
  final List<String>? fields;
  const cascade([this.fields]);
}
