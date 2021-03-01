import 'package:dstore/dstore.dart';
import "package:json_annotation/json_annotation.dart";
part 'models.dstore.dart';
part 'models.g.dart';

@DImmutable()
abstract class Hello with _$Hello {
  @JsonSerializable()
  const factory Hello({required String name2}) = _Hello;
  factory Hello.fromJson(Map<String, dynamic> json) => _$HelloFromJson(json);
}

@DImmutable()
abstract class Hello2 with _$Hello2 {
  @JsonSerializable(explicitToJson: true)
  const factory Hello2(
      {required List<Hello> hellos,
      required Hello h,
      required int age}) = _Hello2;

  factory Hello2.fromJson(Map<String, dynamic> json) => _$Hello2FromJson(json);
}

@JsonSerializable()
class HelloS {
  final String name;

  HelloS(this.name);
  factory HelloS.fromJson(Map<String, dynamic> json) => _$HelloSFromJson(json);

  Map<String, dynamic> toJson() => _$HelloSToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Hello3 {
  final List<Hello> hellos;
  final List<HelloS> hellos2;

  Hello3(this.hellos, this.hellos2);
}
