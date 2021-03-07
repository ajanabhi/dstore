import 'package:dstore/dstore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

@dimmutable
abstract class S1 with _$S1 {
  const factory S1(
      {@JsonKey() required String name,
      @JsonKey(ignore: true) required int s}) = _S1;
}

@Selectors()
// ignore: unused_element
class _AppSelectors {
  static S1 hello(AppState state) {
    final n = state.sample.name.name;
    // final c = state.sample;
    print("hello");
    final s = state.sample.s;
    final sf = state.sample.sf;
    final wf = state.sample.wm;
    // final s1 = state.sample;
    final s2 = state.sample.fint;

    return S1(name: n, s: s);
    // return state.sample.name.name;
  }

  static dynamic hello2(AppState state) {
    final n = state.sample2;
    final n1 = state.sample;
    print("dude");
    final d = _AppSelectors.hello(state);
  }
}
