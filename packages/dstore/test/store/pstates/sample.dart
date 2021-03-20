import 'package:dstore/dstore.dart';
import "package:meta/meta.dart";
import "package:time/time.dart";

import 'sample2/sample2.dart';
part "sample.ps.dstore.dart";

@PState(enableHistory: true)
class $_Sample {
  String name = "hello";
  int age = 0;
  StreamField<int> intStream = StreamField();
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
    await 5.seconds.delay;
    this.isDark = value;
  }
}
