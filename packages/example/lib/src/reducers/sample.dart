import 'package:dstore/dstore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part "sample.dstore.dart";
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

@Reducer()
// ignore: unused_element
class _SampleReducer {
  int count = 0;
  int s = 0;
  User name = User();
  GetTodos todos = GetTodos();

  increment() {
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

  decrement() => this.count = 3;

  increment2(@required int x, y, {int sn = 4, y1, dynamic y2}) =>
      this.count = x;
  increment3(@required int x, y, [int si = 4, s2 = 3]) => this.count = x;
}
