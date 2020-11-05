import 'package:dstore/src/action.dart';
import 'package:meta/meta.dart';

typedef ReducerFn<S> = S Function(S state, Action action);

abstract class ReducerModel<M> {
  M copyWithMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}

class ReducerGroup<S extends ReducerModel> {
  final String group;
  final ReducerFn<S> reducer;
  final S ds;

  ReducerGroup(
      {@required this.group, @required this.reducer, @required this.ds});
}
