import 'dart:svg';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:dstore/dstore.dart';

part "sample.dstore.dart";
part "sample.freezed.dart";
part "sample.g.dart";

@JsonSerializable()
class User {
  String name = "";
  User();
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
  static s() => 3;
}

final GetTodos g = GetTodos();

@PState()
// ignore: unused_element
class _Sample {
  int count = 0;
  int s = 0;
  User name = User();
  GetTodos todos = GetTodos();

  void increment() {
    this.count = 6;
    // [].forEach((element) {
    //   print("ForEach");
    // });
    // [].forEach((element) => print("single"));
    // if (true) {
    //   print("if only");
    // }
    // if (false) print("hello");
    // if (true) {
    //   print("ifelse");
    // } else {
    //   print("else");
    // }
  }

  void decrement() => this.count = 3;

  void increment2(int x, y, {int sn = 4, y1, dynamic y2}) => this.count = x;
  void increment3(int x, y, [int si = 4, s2 = 3]) => this.count = x;

  void fint() async {
    await Future.delayed(const Duration(seconds: 1));
    this.count = 5;
  }
}

@JsonSerializable()
class One {
  final String name;

  One(this.name);
}

class OneAlias = One with EmptyMixin;

@JsonSerializable()
class JsonEx {
  final String name;
  // final OneAlias one;
  JsonEx(
    this.name,
  );
}

class _OneAliasConverter extends JsonConverter<OneAlias, Object> {
  @override
  OneAlias fromJson(Object json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Object toJson(OneAlias object) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

@freezed
abstract class Person with _$Person {
  const factory Person(
      {required String name,
      required int age,
      @Default(2) String? name2}) = _Person;
}

@DImmutable()
abstract class P2 with _$P2 {
  factory P2({required String name, required int age, int? a2}) = _P2;
}
