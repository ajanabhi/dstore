class hasInverse {
  final String field;

  const hasInverse(this.field);
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
}

class id {
  const id();
}

class dgraph {
  final String? type;
  final String? pred;

  const dgraph({this.type, this.pred});
}

class withSubscription {
  const withSubscription();
}

class secret {
  final String field;
  final String? pred;

  secret({required this.field, this.pred});
}

class AuthRule {
  final List<AuthRule>? and;
  final List<AuthRule>? or;
  final AuthRule? not;
  final String? rule;

  const AuthRule({this.and, this.or, this.not, this.rule});
}

class auth {
  final AuthRule? query;
  final AuthRule? add;
  final AuthRule? update;
  final AuthRule? delete;

  const auth({this.query, this.add, this.update, this.delete});
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
}

class remote {
  const remote();
}

class lambda {
  const lambda();
}

class cascade {
  final List<String>? fields;
  const cascade([this.fields]);
}
