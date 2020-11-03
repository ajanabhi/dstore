import 'package:dstore/dstore.dart';
import 'package:dstore_example/src/reducers/sample.dart';
import 'package:dstore_example/src/selectors/types2.dart';

part 'selector_sample.dstore.dart';

class Hello {
  String bollo;
}

class AppState {
  Sample sample;
  Hello hello;
}

@Selectors()
class AppSelectors {
  static AppState _hello(AppState state) {
    final n = state.sample.name.name;
    final c = state.sample;
    // final b = state.hello.bollo;
    // return state.sample.s.toString();
    return null;
    // return state.sample.name.name;
  }
}
