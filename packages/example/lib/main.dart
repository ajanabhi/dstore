import 'package:dstore/dstore.dart';
import 'package:dstore_example/src/pstates/sample.dart';
import 'package:dstore_example/src/sample_state.dart';
import 'package:dstore_example/src/selectors/selector_sample.dart';

void main() async {
  try {
    final p2 = P2(name: "", age: 2);
    print(p2);
    final store = Store(
        meta: createAppStateMeta(sample: SampleMeta),
        stateCreator: () => AppState());

    store.subscribeSelector(AppSelectors.hello, () {
      print(store.state.sample.name);
    });
    print("Sample : ${store.state.sample.name}");
    store.dispatch(SampleActions.changeUserName(name: "New Name"));
    // await Future.delayed(const Duration(seconds: 1));
    print("Done");
  } catch (e) {
    print("Error $e");
  }
}
