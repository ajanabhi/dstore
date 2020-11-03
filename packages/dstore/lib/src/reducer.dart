import 'package:dstore/src/action.dart';
import 'package:meta/meta.dart';

typedef ReducerFn<S> = S Function(S state, Action action);

class ReducerGroup<S> {
  final String group;
  final ReducerFn<S> reducer;
  final S ds;

  ReducerGroup(
      {@required this.group, @required this.reducer, @required this.ds});
}
