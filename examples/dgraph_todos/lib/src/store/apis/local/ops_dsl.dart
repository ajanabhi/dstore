import 'package:dstore/dstore.dart';

import 'local.dart';

@GraphqlOps(api)
class _HelloDSL {
  final todo = Query()
    ..hello(alias: "ho")
    ..hello1
    ..todo(Todo()..text)
    ..users(Person()
      ..name
      ..tags
      ..hello(HelloU()
        ..d__typename
        ..unionfrag_Hello1(Hello1()..name)));
}
