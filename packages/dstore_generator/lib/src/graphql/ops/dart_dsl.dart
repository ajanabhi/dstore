class Query {
  late String hello;
  late String hello1;
  late String ping;
  late Todo todo;
  late Todo users;
}

class Todo {
  late Todo text;
  void fragment(Todo t) => throw Error();
}

class Person {
  late Person name;
  late String screen;
  late String screens;
  late String tags;
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

class Country {
  // Country get
}
