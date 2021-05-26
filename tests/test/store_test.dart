import 'package:dstore_test_suite/tests.dart';
import 'package:test/test.dart';

void main() {
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
