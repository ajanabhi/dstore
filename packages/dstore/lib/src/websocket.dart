import 'package:dstore/dstore.dart';
import 'package:dstore/src/helper_classes.dart';

class WebSocketField<I, R, E> {
  final bool loading;
  final R? data;
  final E? error;
  final bool completed;
  final void Function()? internalUnsubscribe;

  const WebSocketField(
      {this.loading = false,
      this.data,
      this.error,
      this.completed = false,
      this.internalUnsubscribe});

  WebSocketField<I, R, E> copyWith({
    bool? loading,
    Optional<R?> data = optionalDefault,
    Optional<E?> error = optionalDefault,
    bool? completed,
    Optional<void Function()?> internalUnsubscribe = optionalDefault,
  }) {
    return WebSocketField<I, R, E>(
      loading: loading ?? this.loading,
      data: data == optionalDefault ? this.data : data.value,
      error: error == optionalDefault ? this.error : error.value,
      completed: completed ?? this.completed,
      internalUnsubscribe: internalUnsubscribe == optionalDefault
          ? this.internalUnsubscribe
          : internalUnsubscribe.value,
    );
  }
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
