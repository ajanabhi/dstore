class WebSocketRequest<I, R> {
  final String url;
  final String? graphqlQuery;
  final dynamic Function(I)? inputSerializer;
  final R Function(dynamic) responseDeserializer;

  WebSocketRequest(
      {required this.url,
      this.graphqlQuery,
      this.inputSerializer,
      required this.responseDeserializer});
}

class WebSocketField<I, R, E> {
  final bool loading;
  final R? data;
  final E? error;
  final bool completed;
  const WebSocketField(
      {this.loading = false, this.data, this.error, this.completed = false});

  WebSocketField<I, R, E> copyWith({
    bool? loading,
    R? data,
    dynamic? error,
    bool? completed,
  }) {
    return WebSocketField<I, R, E>(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      error: error ?? this.error,
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() =>
      'WebsocketField(loading: $loading, data: $data, error: $error completed :$completed)';
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
