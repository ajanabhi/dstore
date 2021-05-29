import 'dart:io';

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
query params
inpu json
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
    test("should handle string response", () async {
      await storeTester.testHttpAction(SimpleHttpActions.ping(), [
        helloPing(
          loading: true,
        ),
        helloPing(data: "Hello Shelf", completed: true)
      ]);
    });

    test("should handle json responses", () async {
      await storeTester.testHttpAction(SimpleHttpActions.json(), [
        helloJson(
          loading: true,
        ),
        helloJson(
            data: helloJsonResponse(name: "one", count: 2), completed: true)
      ]);
    });

    test("should handle optimistic responses", () async {
      await storeTester.testHttpAction(
          SimpleHttpActions.octet(optimisticResponse: [1, 2]),
          [
            HelloOctet(optimistic: true, data: [1, 2]),
            HelloOctet(data: [1, 2], completed: true)
          ],
          mapEquals: true);
    });
    test("should handle optimistic fail cases", () async {
      await storeTester.testHttpAction(
        SimpleHttpActions.optFail(optimisticResponse: "one"),
        [
          OptimisticFail(optimistic: true, data: "one"),
          OptimisticFail(
              completed: true,
              optimistic: true,
              errorType: HttpErrorType.Response,
              error: "Internal Server Error")
        ],
      );
    });

    test("should handle transformer", () async {
      await storeTester.testHttpAction(SimpleHttpActions.pinInt(), [
        helloJsonTransform<int>(loading: true),
        helloJsonTransform<int>(data: 2, completed: true)
      ]);
    });

    test("should handle transformer with persit data", () async {
      await storeTester.testHttpAction(
          SimpleHttpActions.pagination(
              pathParams: PaginationPathParams(page: 1),
              queryParams: PaginationQueryParams(qp: "1")),
          [
            Pagination(loading: true),
            Pagination(
                completed: true,
                data: PaginationResponse(
                    list: ["one", "two", "three", "four", "five"], nextPage: 2))
          ],
          mapEquals: false);
    });

    test("should send inpu data", () async {
      await storeTester.testHttpAction(
          SimpleHttpActions.jsPost(input: JsonPostRequestBody(name: "one")), [
        JsonPost(loading: true),
        JsonPost(completed: true, data: JsonPostResponse(name: "one"))
      ]);
    });

    test("should upload files", () async {
      final file = File("./sample.txt").readAsBytesSync();
      await storeTester.testHttpAction(
          SimpleHttpActions.fromUpload(
              input: FormUploadRequestBody(name: "one", file: file)),
          [
            FormUpload(loading: true),
            FormUpload(completed: true, data: FormUploadResponse(name: "one"))
          ]);
    });

    test("should track upload progress", () async {
      final file = await File("./sample.txt").readAsBytes();
      await storeTester.testHttpAction(
          SimpleHttpActions.uploadProgress(
              input: file, listenSendProgress: true),
          [
            UploadProgress(loading: true),
            UploadProgress(
                loading: true, progress: HttpProgress(current: 79, total: 79)),
            UploadProgress(
                completed: true, data: UploadProgressResponse(name: "one"))
          ]);
    });

    test("should track downloads", () async {
      await storeTester.testHttpAction(
          SimpleHttpActions.downloadProgress(listenReceiveProgress: true),
          [
            DownloadProgress(loading: true),
            DownloadProgress(
                loading: true, progress: HttpProgress(current: 12, total: 12)),
            DownloadProgress(
              data: [115, 101, 114, 118, 101, 114, 32, 102, 105, 108, 101, 46],
              completed: true,
            ),
          ],
          mapEquals: true);
    });
    test("offline http calls ", () async {
      await storeTester.testHttpAction(
          SimpleHttpActions.offlineOp(offline: true),
          [OfflineOp(completed: true, offline: true)]);
      networkListener.setOnline();
      await 3.seconds.delay;
      expect(store.state.simpleHttp.offlineOp.data, "online");
      final offA = await store.storage!.getOfflineActions();
      expect(offA, <dynamic>[]);
    });
  });
}
