import 'package:dstore/dstore.dart';
import 'package:dstore/src/action.dart';
import 'package:meta/meta.dart';

typedef ReducerFn<S> = S Function(S state, Action action);

typedef AReducerFn<S> = Future<S> Function(S state, Action action);

class AsyncActionField {
  final bool loading;
  final dynamic error;

  AsyncActionField({this.loading = false, this.error});

  // factory AsyncActionField.fromJson(Map<String, dynamic> json) =>
  //     AsyncActionField(loading: json["loading"] as bool, error: json["error"]);
  // Map<String, dynamic> toJson() => {"loading": loading, error: error};
}

abstract class PStateModel<M> {
  M copyWithMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}

class PStateMeta<S extends PStateModel> {
  final String group;
  final ReducerFn<S> reducer;
  final AReducerFn<S> aReducer;
  final S Function() ds;
  final Map<String, dynamic> Function(S) serialize;
  final S Function(Map<String, dynamic>) deserialize;

  PStateMeta(
      {@required this.aReducer,
      @required this.group,
      this.serialize,
      this.deserialize,
      @required this.reducer,
      @required this.ds});
}
