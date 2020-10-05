import 'package:dstore/dstore.dart';
import 'package:meta/meta.dart';
part "sample.dstore.dart";

@Reducer()
// ignore: unused_element
class _SampleReducer {
  int count = 0;
  int s = 0;
  increment() {
    var count2 = 4;
    count++;
    count = 3;
    count2 = 5;
    this.count = 6;
    print(count2);
  }

  decrement() => this.count = 3;
}
