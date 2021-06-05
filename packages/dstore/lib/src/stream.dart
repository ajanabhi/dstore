import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:json_annotation/json_annotation.dart';

part "stream.dstore.dart";

class StreamPayload<D> {
  final Stream<D> stream;
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
