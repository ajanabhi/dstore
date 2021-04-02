import 'package:dstore/dstore.dart';
import "package:meta/meta.dart";
import "package:time/time.dart";

import 'sample2/sample2.dart';
part "sample.ps.dstore.dart";

@PState()
class $_Sample {
  String name = "hello";
  int age = 0;
  StreamField<int, Object> intStream = StreamField();
  List<String> list = [];
  bool isDark = false;
  late final $_Sample2 s;

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
    this.age = 2;
    final s1 = this.age;
    await 5.seconds.delay;
    this.isDark = value;
  }

  void test(int age2) {
    this.age = age2;
  }
}
