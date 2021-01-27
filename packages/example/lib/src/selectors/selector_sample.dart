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
  static dynamic hello(AppState state) {
    final n = state.sample.name.name;
    // final c = state.sample;
    return state.sample.s.toString();
    // return state.sample.name.name;
  }
}
