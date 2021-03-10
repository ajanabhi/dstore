import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:dstore/src/action.dart';
import 'package:json_annotation/json_annotation.dart';
part "pstate.dstore.dart";
part 'pstate.g.dart';

typedef ReducerFn = dynamic Function(dynamic state, Action action);

typedef AReducerFn = Future<dynamic> Function(dynamic state, Action action);

@dimmutable
abstract class AsyncActionField with _$AsyncActionField {
  @JsonSerializable()
  const factory AsyncActionField(
      {@Default(false) bool loading,
      @Default(null) dynamic error}) = _AsyncActionField;

  factory AsyncActionField.fromJson(Map<String, dynamic> json) =>
      _$AsyncActionFieldFromJson(json);
}

@dimmutable
abstract class StreamField<D> with _$StreamField<D> {
  const factory StreamField({
    D? data,
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
  final dynamic Function(S) serializer;
  final S Function(dynamic) deserializer;
  final bool encryptonRest;

  PStateStorageMeta(
      {this.encryptonRest = false,
      required this.serializer,
      required this.deserializer});
}

class PStateMeta<S extends PStateModel> {
  final Type type;
  final ReducerFn? reducer;
  final AReducerFn? aReducer;
  final S Function() ds;

  final PStateStorageMeta<S>? sm;

  const PStateMeta(
      {this.aReducer,
      this.sm,
      required this.type,
      this.reducer,
      required this.ds});
}
