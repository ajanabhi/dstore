import 'package:dstore/dstore.dart';

import 'local.dart';

@GraphqlOps(api)
class _HelloDSL {
  final todo = Query()
    ..hello
    ..hello1(id: "dude")
    ..todo(Todo().text.text)
    ..users(Person().name.tags
      ..hello(HelloU().d__typename..unionfrag_Hello1(Hello1().name)));
}

class Query {
  late void hello;
  void hello1({String? id}) => throw Error();
  late void ping;
  void todo(Todo t) => throw Error();
  void users(Person t) => throw Error();
  void hellou(HelloU t) => throw Error();
}

class Todo {
  late Todo text;
}

class Person {
  late Person name;
  late Person screen;
  late Person screens;
  late Person tags;
  Person hello(HelloU u) => throw Error();
  Person helloa(HelloU u) => throw Error();
}

class Hello1 {
  late Hello1 name;
  late Hello1 one;
}

class Hello2 {
  late Hello2 name;
  late Hello2 two;
}

class HelloU {
  late HelloU d__typename;
  HelloU unionfrag_Hello1(Hello1 h1) => throw Error();
  HelloU unionfrag_Hello2(Hello2 h2) => throw Error();
}

class Address {
  late Address street;
  late Address zip;
  Address country(Country c) => throw Error();
}

class Country {
  late Country code;
  late Country name;
}

final q = Query()
  ..todo(Todo().text)
  ..users(Person()
      .name
      .tags
      .name
      .hello(HelloU().d__typename.unionfrag_Hello1(Hello1().name)));
