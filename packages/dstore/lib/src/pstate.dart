import 'dart:async';
import 'dart:collection';

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

class PStateStorageMeta<S extends PStateModel, SM> {
  final dynamic Function(S) serializer;
  final S Function(SM) deserializer;
  final bool encryptonRest;

  const PStateStorageMeta(
      {this.encryptonRest = false,
      required this.serializer,
      required this.deserializer});
}

class PStateMeta<S extends PStateModel> {
  final String type;
  final ReducerFn? reducer;
  final AReducerFn? aReducer;
  final Map<String, Httpmeta>? httpMetaMap;
  final Map<String, List<String>>? actionsMeta;
  final S Function() ds;

  final PStateStorageMeta<S, dynamic>? sm;
  final bool enableHistory;

  const PStateMeta(
      {this.aReducer,
      this.sm,
      required this.type,
      this.actionsMeta,
      this.httpMetaMap,
      this.enableHistory = false,
      this.reducer,
      required this.ds});
}

class PStateHistory<S extends PStateModel> {
  final Queue _history = ListQueue();
  final Queue _redos = ListQueue();
  final S model;

  final int? limit;

  PStateHistory({required this.model, this.limit});

  bool get canRedo => _redos.isNotEmpty;
  bool get canUndo => _history.isNotEmpty;

  void add(Map<String, dynamic> patch) {
    if (limit != null && limit == 0) {
      return;
    }
    _history.addLast(patch);
    _redos.clear();

    if (limit != null && _history.length > limit!) {
      if (limit! > 0) {
        _history.removeFirst();
      }
    }
  }

  void clear() {
    _history.clear();
    _redos.clear();
  }

  void redo() {
    if (canRedo) {
      final change = _redos.removeFirst()..execute();
      _history.addLast(change);
    }
  }

  void undo() {
    if (canUndo) {
      final change = _history.removeLast()..undo();
      _redos.addFirst(change);
    }
  }
}
