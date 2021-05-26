import 'dart:async';

import 'package:dstore_test_suite/tests.dart';
import 'package:test/test.dart';
import "./pstates/async_methods.dart" as asyncmethods;
import "./pstates/sync_methods.dart" as syncmethods;
import "./pstates/history_pstate.dart" as historypstate;

void main() {
  setUpAll(() async {
    if (store.isReady) {
      return;
    }
    final f = Completer<dynamic>();
    store.listenForReadyState(() {
      print("store is ready");
      f.complete();
    });
    return f.future;
  });
  print("executing tests");
  asyncmethods.main();
  syncmethods.main();
  historypstate.main();
  group('Store tests', () {
    test("should get appVersion from pubspec", () {
      expect(store.appVersion, "1.0.0");
    });
    test("should contain meta for all state fields", () {
      final stateKeys = store.state.toMap().keys;
      expect(store.internalMeta.keys, stateKeys);
    });
  });
}
