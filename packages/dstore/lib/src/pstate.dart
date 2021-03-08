import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:dstore/src/action.dart';
part "pstate.dstore.dart";

typedef ReducerFn = dynamic Function(dynamic state, Action action);

typedef AReducerFn = Future<dynamic> Function(dynamic state, Action action);

@dimmutable
abstract class AsyncActionField with _$AsyncActionField {
  const factory AsyncActionField(
      {@Default(false) bool loading,
      @Default(null) dynamic error}) = _AsyncActionField;
}

@dimmutable
abstract class StreamField<D> with _$StreamField<D> {
  const factory StreamField({
    D? d,
    StreamSubscription? internalSubscription,
    @Default(null) dynamic? error,
    @Default(false) bool listening,
    @Default(false) bool completed,
  }) = _StreamField<D>;
}

abstract class PStateModel<M> {
  M copyWithMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}

class PStateStorageMeta<S extends PStateModel> {
  final List<String> keys;
  final dynamic Function(S) serializer;
  final S Function(dynamic) deserializer;
  final bool encryptonRest;

  PStateStorageMeta(
      {required this.keys,
      this.encryptonRest = false,
      required this.serializer,
      required this.deserializer});
}

class PStateMeta<S extends PStateModel> {
  final Type type;
  final ReducerFn? reducer;
  final AReducerFn? aReducer;
  final S Function() ds;

  final PStateStorageMeta? sm;

  const PStateMeta(
      {this.aReducer,
      this.sm,
      required this.type,
      this.reducer,
      required this.ds});
}
