import 'package:dstore/dstore.dart';
import 'package:dstore_test_suite/src/store/api/openapi/local.dart';
import 'package:dstore_test_suite/src/store/app_state.dart';
import 'package:dstore_test_suite/src/store/pstates/http/simple_http_ps.dart';
import 'package:test/test.dart';
import "package:time/time.dart";

void main() {
  group("http pstate", () {
    test("should have default value", () {
      expect(store.state.simpleHttp.ping.loading, false);
    });
    test("", () async {
      await storeTester.testHttpAction(SimpleHttpActions.ping(),
          helloPing(data: "Hello Shelf", completed: true));
    });
  });
}
