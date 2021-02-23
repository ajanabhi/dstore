import 'package:dstore/dstore.dart';
import 'package:dstore_example/src/selectors/selector_sample.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
part 'sample2.ps.dstore.dart';

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
