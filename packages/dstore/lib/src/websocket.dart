import 'package:dstore/dstore.dart';
import 'package:dstore/src/helper_classes.dart';
part "websocket.dstore.dart";

@dimmutable
abstract class WebSocketField<I, R, E> with _$WebSocketField<I, R, E> {
  const factory WebSocketField({
    @Default(false) bool loading,
    R? data,
    E? error,
    @Default(false) bool completed,
    void Function()? internalUnsubscribe,
  }) = _WebSocketField<I, R, E>;
}

class WebSocketPayload<I, R, E> {
  final String url;
  final I? data;
  final R Function(dynamic) responseDeserializer;
  final WebSocketField Function(WebSocketField)? transformer;
  final dynamic Function(I)? inputSerializer;
  final E Function(dynamic)? errorDeserializer;
  final Map<String, dynamic>? headers;
  final bool unsubscribe;

  WebSocketPayload(
      {required this.url,
      this.data,
      required this.responseDeserializer,
      this.transformer,
      this.inputSerializer,
      this.unsubscribe = false,
      this.errorDeserializer,
      this.headers});
}
