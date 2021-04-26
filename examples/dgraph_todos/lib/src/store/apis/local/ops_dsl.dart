import 'package:dstore/dstore.dart';

import 'local.dart';

@GraphqlOps(api)
class _HelloDSL {
  final todo = Query()
    ..hello(alias: "ho")
    ..hello1
    ..todo(Todo()..text)
    ..todo(Todo())
    ..users(Person(), alias: "users3")
    ..users(Person()
      ..name
      ..tags
      ..hello(HelloU()..unionfrag_Hello1(Hello1()..name)));
}
