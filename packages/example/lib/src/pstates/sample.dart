import 'package:dstore_example/src/pstates/sample2.dart';
import 'package:dstore_example/src/selectors/selector_sample.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:dstore/dstore.dart';
part "sample.ps.dstore.dart";
part "sample.dstore.dart";
part "sample.g.dart";

@DImmutable()
abstract class User with _$User {
  @JsonSerializable()
  const factory User({required String name}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

dynamic s(dynamic a) => a;

@WebSocketRequest(url: "ws2", responseDeserializer: s)
class WsMessage = WebSocketField<dynamic, dynamic, dynamic> with EmptyMixin;

@PState()
class $Sample {
  int count = 0;
  @excludeThisKeyWhilePersist
  int s = 0;
  @JsonKey(ignore: true, defaultValue: "sample")
  String n = "hello";
  @excludeThisKeyWhilePersist
  User name = User(name: "first2");
  // GetTodos todos = GetTodos();

  // StreamField sf = StreamField();

  // WsMessage wm = WsMessage();

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

  void increment2(int x, dynamic y, {int sn = 4, dynamic y1, dynamic y2}) =>
      this.count = x;
  void increment3(int x, dynamic y, [int si = 4, dynamic s2 = 3]) =>
      this.count = x;
  void changeUserName(String name) {
    this.name = this.name.copyWith(name: name);
  }

  void changeS(int s) {
    this.s = s;
  }

  void fint() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
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

@DImmutable()
abstract class P2 with _$P2 {
  factory P2({required String name, required int age, int? a2}) = _P2;
}
