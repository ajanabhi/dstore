import 'package:dstore/dstore.dart';

Middleware<S> createFormMiddleware<S extends AppStateI>(
    [DioMiddlewareOptions? options]) {
  final dio = Dio();
  return (Store<S> store, Dispatch next, Action action) {
    if (action.isProcessed || action.http == null) {
      return next(action);
    }
    _processHttpAction(options, store, action, dio);
  };
}
