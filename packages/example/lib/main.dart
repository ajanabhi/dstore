import 'package:dstore/dstore.dart';
import 'package:dstore_example/src/pstates/sample.dart';
import 'package:dstore_example/src/pstates/sample2.dart';
import 'package:dstore_example/src/sample_state.dart';
import 'package:dstore_example/src/selectors/selector_sample.dart';
import "package:ansicolor/ansicolor.dart";

void main() async {
  ansiColorDisabled = false;
  final s2 = S1(name: "n1", s: 3);
  final s3 = s2.copyWith(op3: "op3", s: 4);
  final s4 = s3.copyWith(op3: null, name: "s2");
  print(s2);
  print(s3);
  print(s4);
  // try {
  //   final p2 = P2(name: "", age: 2);
  //   print(p2);
  //   final store = Store(
  //       meta: createAppStateMeta(sample: SampleMeta),
  //       stateCreator: () => AppState());

  //   store.subscribeSelector(AppSelectors.hello, () {
  //     print(store.state.sample.name);
  //   });
  //   print("Sample : ${store.state.sample.name}");
  //   store.dispatch(SampleActions.changeUserName(name: "New Name"));
  //   // await Future.delayed(const Duration(seconds: 1));
  //   print("Done");
  // } catch (e) {
  //   print("Error $e");
  // }
}
