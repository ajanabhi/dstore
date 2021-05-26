import 'package:dstore/dstore.dart';
import 'package:dstore_test/dstore_test.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_async_ps.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_ps.dart';

part "app_state.dstore.dart";

@AppStateAnnotation()
void $_AppState(Simple simple, SimpleAsync simpleAsync) {}

final store = createStore(handleError: (error) {
  print("Uncaught error in store  $error");
});

final storeTester = StoreTester(store);
