import 'package:dstore/dstore.dart';
import 'package:dstore_test_suite/src/store/api/openapi/local.dart';
import 'package:dstore_test_suite/src/store/app_state.dart';
import 'package:dstore_test_suite/src/store/pstates/http/simple_http_ps.dart';
import 'package:test/test.dart';
import "package:time/time.dart";

/* 
text response 
octet stream response 
json response
optimistic 
optimistic fail
transformer
transformer with pagination
form uploads
file uploads
upload download progress
offline
offline can process /not process
Graphql 
queries
mutations


*/
void main() {
  group("http pstate", () {
    test("should have default value", () {
      expect(store.state.simpleHttp.ping.loading, false);
    });
    test("", () async {
      await storeTester.testHttpAction(SimpleHttpActions.ping(), [
        helloPing(
          loading: true,
        ),
        helloPing(data: "Hello Shelf", completed: true)
      ]);
      print("don http");
    });
  });
}
