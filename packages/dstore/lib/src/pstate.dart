import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:dstore/src/action.dart';

typedef ReducerFn = dynamic Function(dynamic state, Action action);

typedef AReducerFn = Future<dynamic> Function(dynamic state, Action action);

class AsyncActionField {
  final bool loading;
  final dynamic error;

  AsyncActionField({this.loading = false, this.error});

  // factory AsyncActionField.fromJson(Map<String, dynamic> json) =>
  //     AsyncActionField(loading: json["loading"] as bool, error: json["error"]);
  // Map<String, dynamic> toJson() => {"loading": loading, error: error};
}

class StreamField<D> {
  final StreamSubscription? internalSubscription;
  final D? data;
  final dynamic? error;
  final bool loading;
  final bool completed;

  StreamField(
      {this.loading = false,
      this.completed = false,
      this.internalSubscription,
      this.data,
      this.error});

  StreamField<D> copyWith({
    StreamSubscription? internalSubscription,
    D? data,
    dynamic? error,
    bool? loading,
    bool? completed,
  }) {
    return StreamField<D>(
      internalSubscription: internalSubscription ?? this.internalSubscription,
      data: data ?? this.data,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      completed: completed ?? this.completed,
    );
  }
}

abstract class PStateModel<M> {
  M copyWithMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}

class PStateMeta<S extends PStateModel> {
  final int group;
  final ReducerFn? reducer;
  final AReducerFn? aReducer;
  final S Function() ds;
  final Map<String, dynamic> Function(S)? serialize;
  final S Function(Map<String, dynamic>)? deserialize;

  const PStateMeta(
      {this.aReducer,
      required this.group,
      this.serialize,
      this.deserialize,
      this.reducer,
      required this.ds});
}
