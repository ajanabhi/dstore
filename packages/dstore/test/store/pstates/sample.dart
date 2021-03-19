import 'package:dstore/dstore.dart';
import "package:meta/meta.dart";
import "package:time/time.dart";
part "sample.ps.dstore.dart";

@PState()
// ignore: unused_element
class _Sample {
  String name = "hello";
  int age = 0;
  StreamField<int> intStream = StreamField();
  List<String> list = [];
  bool isDark = false;

  void changeName(String newName) {
    this.name = newName;
  }

  void changeAge(int newAge) {
    this.age = newAge;
  }

  void addToList(String item) {
    this.list = [...this.list, item];
  }

  Future<void> changeTheme(bool value) async {
    await 5.seconds.delay;
    this.isDark = value;
  }
}
