import 'package:dstore/dstore.dart';
import 'package:dstore_example/src/pstates/sample.dart';
import 'package:dstore_example/src/sample_state.dart';
import 'package:dstore_example/src/selectors/types2.dart';

part 'selector_sample.dstore.dart';

// class Hello {
//   String bollo = "";
// }

// class AppState {
//   User? sample;
//   Hello hello = Hello();
// }

@Selectors()
// ignore: unused_element
class _AppSelectors {
  static S1 hello(AppState state) {
    final n = state.sample.name.name;
    // final c = state.sample;
    print("hellos");
    final s = state.sample.s;
    return S1(name: n, s: s);
    // return state.sample.name.name;
  }
}

@DImmutable()
abstract class S1 with _$S1 {
  const factory S1({required String name, required int s}) = _S1;
}
