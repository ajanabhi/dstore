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
  final bool listening;
  final bool completed;

  StreamField(
      {this.listening = false,
      this.completed = false,
      this.internalSubscription,
      this.data,
      this.error});

  StreamField<D> copyWith({
    StreamSubscription? internalSubscription,
    Nullable<D>? data,
    Nullable<dynamic>? error,
    bool? listening,
    bool? completed,
  }) {
    return StreamField<D>(
      internalSubscription: internalSubscription ?? this.internalSubscription,
      data: data != null ? data.value : this.data,
      error: error != null ? error.value : this.error,
      listening: listening ?? this.listening,
      completed: completed ?? this.completed,
    );
  }
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
  final int group;
  final ReducerFn? reducer;
  final AReducerFn? aReducer;
  final S Function() ds;

  final PStateStorageMeta? sm;

  const PStateMeta(
      {this.aReducer,
      this.sm,
      required this.group,
      this.reducer,
      required this.ds});
}
