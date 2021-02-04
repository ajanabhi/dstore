import 'package:dstore/dstore.dart';
import 'package:meta/meta.dart';
part 'sample2.dstore.dart';

@PState()
// ignore: unused_element
class _Sample2 {
  int count = 0;
  String name = "hello";
  List<String> s = [];
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
  }
}
