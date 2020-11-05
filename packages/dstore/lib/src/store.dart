import 'package:dstore/src/reducer.dart';
import 'package:meta/meta.dart';

class Store<S extends AppStateI> {
  final Map<String, ReducerGroup<ReducerModel>> reducers;
  dynamic dispatch;
  S _state;

  Store(
      {@required this.reducers,
      @required S Function() stateCreator,
      S initialState}) {}

  get state => _state;
}

abstract class AppStateI<S> {
  S copyWithMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
  List<String> getFields();
}

dynamic compose(List<Function> funcs) {
  if (funcs.length == 0) {
    return (dynamic arg) => arg;
  }
  if (funcs.length == 1) {
    return funcs[0];
  }
  // return funcs.reduce((value, element) => )
}
