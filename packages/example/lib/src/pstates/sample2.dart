import 'dart:ffi';

import 'package:dstore/dstore.dart';
import 'package:dstore_example/src/selectors/selector_sample.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:union/union.dart';
part 'sample2.ps.dstore.dart';
part 'sample2.dstore.dart';
part 'sample2.g.dart';

@PState()
// ignore: unused_element
class $Sample2 {
  int count = 0;
  String name = "hello2";
  String? comment;
  void increment() {
    this.count += 1;
    print("hello");
    try {
      this.name = "hello2";
    } on Exception catch (s, sp2) {
      print(s);
    } catch (e2) {} finally {
      print("final");
    }
    for (var i = 0; i < 10; i++) this.count = 4;
  }
}

@DImmutable()
abstract class TU with _$TU {
  @JsonSerializable()
  const factory TU({required String name, @Default("hello") String h}) = _TU;
  factory TU.fromJson(Map<String, dynamic> json) => _$TUFromJson(json);
}
