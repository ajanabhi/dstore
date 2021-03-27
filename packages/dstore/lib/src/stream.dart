import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:json_annotation/json_annotation.dart';

part "stream.dstore.dart";

class StreamPayload {
  final Stream<dynamic> stream;
  final bool cancelOnError;

  StreamPayload({required this.stream, this.cancelOnError = false});
}

@dimmutable
void $_StreamField<D, E>({
  D? data,
  StreamSubscription<dynamic>? internalSubscription,
  E? error,
  bool listening = false,
  bool firstEventArrived = false,
  bool completed = false,
}) {}

extension StreamFieldExtension<D, E> on StreamField<D, E> {
  T when<T>(
      {required T Function() listening,
      required T Function(D data) data,
      required T Function(E error) error,
      required T Function() completed}) {
    if (this.data != null) {
      return data(this.data!);
    } else if (this.error != null) {
      return error(this.error!);
    } else if (this.completed) {
      return completed();
    } else {
      return listening();
    }
  }
}
