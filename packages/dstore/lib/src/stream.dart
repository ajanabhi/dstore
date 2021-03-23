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
abstract class StreamField<D> with _$StreamField<D> {
  const factory StreamField({
    D? data,
    StreamSubscription<dynamic>? internalSubscription,
    @Default(null) dynamic? error,
    @Default(false) bool listening,
    @Default(false) bool firstEventArrived,
    @Default(false) bool completed,
  }) = _StreamField<D>;
}
