import 'package:dstore/dstore.dart';
import 'package:dstore_test/dstore_test.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_async_ps.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_history_ps.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_ps.dart';

part "app_state.dstore.dart";

@AppStateAnnotation()
void $_AppState(
    Simple simple, SimpleAsync simpleAsync, SimpleHistory simpleHistory) {}

final store = createStore(
    handleError: (error) {
      print("Uncaught error in store  $error");
    },
    storageOptions: StorageOptions(
      storage: InMemoryStorage(),
      onWriteError: (error, store, action) async {
        print("storage write error $error");
        return StorageWriteErrorAction.ignore;
      },
      onReadError: (dynamic error) {
        print("Read error");
      },
    ));

final storeTester = StoreTester(store: store, waitForStorage: true);
