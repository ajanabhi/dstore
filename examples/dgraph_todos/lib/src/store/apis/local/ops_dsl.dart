import 'package:dstore/dstore.dart';

import 'local.dart';

@GraphqlOps(api)
class _HelloDSL {
  final todo = Query()
    ..hello
    ..hello1(id: "dude")
    ..todo(Todo()..text)
    ..users(Person()
      ..name
      ..tags
      ..hello(HelloU()
        ..d__typename
        ..unionfrag_Hello1(Hello1()..name)));
}

class Query {
  late void hello;
  void hello1({String? id}) => throw Error();
  late void ping;
  void todo(Todo t) {}
  void users(Person t) => throw Error();
  void hellou(HelloU t) => throw Error();
}

class Todo {
  void text;
}

class Person {
  void name;
  void screen;
  void screens;
  void tags;
  void hello(HelloU u) {}
  void helloa(HelloU u) {}
}

class Hello1 {
  void name;
  void one;
}

class Hello2 {
  void name;
  void two;
}

class HelloU {
  void d__typename;
  void unionfrag_Hello1(Hello1 h1) {}
  void unionfrag_Hello2(Hello2 h2) {}
}

class Address {
  void street;
  void zip;
  void country(Country c) {}
}

class Country {
  void code;
  void name;
}
