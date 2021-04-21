class Query {
  String get hello => throw Error();
  String get hello1 => throw Error();
  String get ping => throw Error();
  Todo get todo => throw Error();
  Todo get users => throw Error();
}

class Todo {
  Todo get text => throw Error();
  void fragment(Todo t) => throw Error();
}

class Person {
  Person get name => throw Error();
  String get screen => throw Error();
  String get screens => throw Error();
  String get tags => throw Error();
}

class Hello1 {
  Hello1 get name => throw Error();
  Hello1 get one => throw Error();
}

class Hello2 {
  Hello2 get name => throw Error();
  Hello2 get two => throw Error();
}

class HelloU {
  HelloU get d__typename => throw Error();
  HelloU unionfrag_Hello1(Hello1 h1) => throw Error();
  HelloU unionfrag_Hello2(Hello2 h2) => throw Error();
}
