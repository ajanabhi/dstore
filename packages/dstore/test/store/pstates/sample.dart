import 'package:dstore/dstore.dart';
import "package:meta/meta.dart";

part "sample.ps.dstore.dart";

@PState()
class _Sample {
  String name = "hello";
  int age = 0;
  void changeName(String newName) {
    this.name = newName;
  }

  void changeAge(int newAge) {
    this.age = newAge;
  }

  Future<void> changeNameAfterDelay(String newName) async {
    await Future.delayed(Duration(seconds: 5));
    this.name = newName;
  }
}
