class Query {
  late Query hello;
  late Query hello1;
  late Query ping;
  Query todo(Todo t) => throw Error();
  Query users(Person t) => throw Error();
  Query hellou(HelloU t) => throw Error();
}

class Todo {
  late Todo text;
  void fragment(Todo t) => throw Error();
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

final q = Query().todo(Todo().text).users(Person()
    .name
    .tags
    .hello(HelloU().d__typename.unionfrag_Hello1(Hello1().name)));
