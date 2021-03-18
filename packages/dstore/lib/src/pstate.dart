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
      @Default(false) bool completed,
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

class PStateStorageMeta<S extends PStateModel<S>, SM> {
  final dynamic Function(S) serializer;
  final S Function(SM) deserializer;
  final bool encryptonRest;

  const PStateStorageMeta(
      {this.encryptonRest = false,
      required this.serializer,
      required this.deserializer});
}

class PStateMeta<S extends PStateModel<S>> {
  final String type;
  final ReducerFn? reducer;
  final AReducerFn? aReducer;

  final Map<String, Httpmeta>? httpMetaMap;
  final Map<String, List<String>>? actionsMeta;
  final S Function() ds;

  final PStateStorageMeta<S, dynamic>? sm;
  final bool enableHistory;
  // final int? historyLimit;

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

class PStateHistory<S extends PStateModel<S>> {
  final Queue<Map<String, dynamic>> _history = ListQueue();
  final Queue<Map<String, dynamic>> _redos = ListQueue();
  final int? limit;
  PStateHistory(this.limit);

  void internalAdd(Map<String, dynamic> patch) {
    if (limit != null && limit! <= 0) {
      throw ArgumentError.value("limit should be more than 0");
    }
    _history.addLast(patch);
    _redos.clear();

    if (limit != null && _history.length > limit!) {
      _history.removeFirst();
    }
  }

  void internalClear() {
    _history.clear();
    _redos.clear();
  }

  S? internalRedo(S currentState) {
    if (canRedo) {
      final patch = _redos.removeFirst();
      _history.addLast(patch);
      final newState = currentState.copyWithMap(patch) as PStateHistoryMixin;
      newState._psHistory = this;
      return newState as S;
    }
  }

  S? internalUndo(S initialState) {
    if (canUndo) {
      final patch = _history.removeLast();
      _redos.addFirst(patch);
      if (_history.isEmpty) {
        return initialState;
      } else {
        final map = <String, dynamic>{};
        _history.forEach((patch) {
          map.addAll(patch);
        });
        final newState = initialState.copyWithMap(patch) as PStateHistoryMixin;
        newState._psHistory = this;
        return newState as S;
      }
    }
  }

  bool get canRedo => _redos.isNotEmpty;
  bool get canUndo => _history.isNotEmpty;
}

mixin PStateHistoryMixin<S extends PStateModel<S>> {
  PStateHistory<S>? _psHistory;
  PStateHistory<S> get internalPSHistory => _psHistory!;
  bool get canRedo => internalPSHistory.canRedo;
  bool get canUndo => internalPSHistory.canUndo;
}
