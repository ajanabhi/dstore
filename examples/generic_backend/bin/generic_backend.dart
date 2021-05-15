import "dart:io";
import 'dart:math';
import "package:shelf_plus/shelf_plus.dart";
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

void main() => shelfRun(init);

Handler init() {
  final overrideHeaders = {
    ACCESS_CONTROL_ALLOW_ORIGIN: '*',
    'Content-Type': 'application/octet-stream'
  };

  final app = Router().plus;
  app.use(corsHeaders(headers: overrideHeaders));
  app.get("/", () => "Hello Shelf");
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
