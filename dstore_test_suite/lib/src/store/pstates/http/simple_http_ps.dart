import 'package:dstore/dstore.dart';
import 'package:dstore_test_suite/src/store/api/openapi/local.dart';
part 'simple_http_ps.ps.dstore.dart';

@PState()
class $_SimpleHttp {
  helloPing ping = helloPing();
  helloJson json = helloJson();
  HelloOctet octet = HelloOctet();
  OptimisticFail optFail = OptimisticFail();
  @HttpRequestExtension(transformer: pingTransform)
  helloJsonTransform<int> pinInt = helloJsonTransform();
}

helloJsonTransform<int> pingTransform(
    helloJsonTransform<int> input, helloJsonResponse responseFromServer) {
  return input;
}
