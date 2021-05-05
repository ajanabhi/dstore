@JS()
library dgraph_lambda;

import 'dart:js';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@anonymous
@JS()
abstract class GraphQLResponse {
  external dynamic /*Record<Stringdynamic>*/ get data;
  external set data(dynamic /*Record<Stringdynamic>*/ v);
  external List<dynamic /*{ message: string }*/ > get errors;
  external set errors(List<dynamic /*{ message: string }*/ > v);
  external factory GraphQLResponse(
      {dynamic /*Record<Stringdynamic>*/ data,
      List<dynamic /*{ message: string }*/ > errors});
}

@anonymous
@JS()
abstract class GraphQLEventWithParent {
  external dynamic /*Record<Stringdynamic>|Null*/ get parent;
  external set parent(dynamic /*Record<Stringdynamic>|Null*/ v);
  external dynamic /*Record<Stringdynamic>*/ get args;
  external set args(dynamic /*Record<Stringdynamic>*/ v);

  external dynamic
      /*{
      query: (s: string, vars: Record<string, any> | undefined) => Promise<GraphQLResponse>
      mutate: (s: string) => Promise<GraphQLResponse>
    }*/
      get dql;
  external set dql(
      dynamic
          /*{
      query: (s: string, vars: Record<string, any> | undefined) => Promise<GraphQLResponse>
      mutate: (s: string) => Promise<GraphQLResponse>
    }*/
          v);
}

@JS()
abstract class Promise<T> {}

@JS()
@anonymous
abstract class _GraphQLEventWithParent {
  external Promise<GraphQLResponse> Function(
      String, dynamic /*Record<Stringdynamic>|dynamic*/) get graphql;
}

extension GraphQLEventWithParentExt on GraphQLEventWithParent {
  Future<GraphQLResponse> graphql(String query, Map<String, dynamic>? vars) {
    Object t = this;
    final tt = t as _GraphQLEventWithParent;
    return promiseToFuture(
        tt.graphql(query, vars != null ? convertMapToJSObject(vars) : null));
  }
}

dynamic convertMapToJSObject(Map map) {
  final jsObj = newObject() as Object;
  map.forEach((dynamic key, dynamic value) {
    final name = key.toString();
    if (value is Map) {
      setProperty(jsObj, name, convertMapToJSObject(value));
    } else {
      setProperty(jsObj, name, value);
    }
  });
  return jsObj;
}

@JS()
external void addGraphQLResolvers(
    dynamic /*JSMap of <String,dynamic Function(GraphQLEventWithParent)>*/ resolvers);
