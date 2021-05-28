import "dart:io";
import 'dart:math';
import 'dart:typed_data';
import 'package:genericbackend/src/openapispec/openapi_spec.dart';
import "package:shelf_plus/shelf_plus.dart";
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

void main() {
  generateSpec();
  shelfRun(init);
}

Handler init() {
  final overrideHeaders = {
    ACCESS_CONTROL_ALLOW_ORIGIN: '*',
    'Content-Type': 'application/json'
  };

  final app = Router().plus;
  // app.use(corsHeaders(headers: overrideHeaders));
  app.get("/", () => "Hello Shelf");
  app.get("/json", () {
    final json = <String, dynamic>{"name": "one", "count": 2};
    print("json $json");
    return json;
  });
  app.get("/octet", () {
    final result = Uint8List.fromList([1, 2]);
    print("Octet Result $result");
    return result;
  });
  app.get("/optimistic-fail", () {
    throw Exception();
  });
  app.get("/file", () => File("siva.jpeg"));
  app.get("/siva", () => File("siva.jpeg").readAsBytesSync());
  app.get("/stream", () => generateStream());
  return app;
}

Stream<List<int>> generateStream() async* {
  yield [Random().nextInt(5)];
  print("one");
  await Future.delayed(const Duration(milliseconds: 400), () {});
  yield [Random().nextInt(100)];
  await Future.delayed(const Duration(milliseconds: 400), () {});
  print("done stream");
  yield [5];
}
