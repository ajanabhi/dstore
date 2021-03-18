import 'package:dstore/dstore.dart';
import "package:meta/meta.dart";

part "sample.ps.dstore.dart";

@PState()
// ignore: unused_element
class _Sample {
  String name = "hello";
  int age = 0;

  List<String> list = [];

  void changeName(String newName) {
    this.name = newName;
  }

  void changeAge(int newAge) {
    this.age = newAge;
  }

  void addToList(String item) {
    this.list = [...this.list, item];
  }
}
