import 'package:meta/meta.dart';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/reducer.dart';
import 'package:dstore/src/selector.dart';

typedef Dispatch = dynamic Function(Action action);

typedef Middleware<State extends AppStateI> = dynamic Function(
    Store<State> store, Dispatch next, Action action);

typedef Callback = dynamic Function();

class Store<S extends AppStateI> {
  final Map<String, ReducerGroup<ReducerModel>> reducers;
  final Map<String, List<_SelectorListener>> selectorListeners = {};
  List<Dispatch> _dispatchers;
  Map<String, String> _reducerGroupToStateKeyMap = {};
  S _state;

  Store(
      {@required this.reducers,
      @required S Function() stateCreator,
      List<Middleware<S>> middlewares = const [],
      S initialState}) {
    _dispatchers = _createDispatchers(middlewares);
    _prepareNormalStore(stateCreator);
  }

  get state => _state;

  void _prepareNormalStore(S Function() stateCreator) {
    final AppStateI s = stateCreator();
    final Map<String, dynamic> map = {};
    this.reducers.forEach((key, rg) {
      _reducerGroupToStateKeyMap[rg.group] = key;
      map[key] = rg.ds;
    });
    _state = s.copyWithMap(map);
  }

  List<Dispatch> _createDispatchers(List<Middleware<S>> middlewares) {
    final dispatchers = <Dispatch>[]..add(_defaultDispatch);
    middlewares.reversed.forEach((m) {
      final next = dispatchers.last;
      dispatchers.add((Action action) => m(this, next, action));
    });
    return dispatchers.reversed.toList();
  }

  dynamic _defaultDispatch(Action action) {}

  

  /* public methods  */

  String getStateKeyForReducerGroup(String key) {
    return this._reducerGroupToStateKeyMap[key];
  }

  dynamic dispatch(Action action) {
    _dispatchers[0](action);
  }

  dynamic subscribeSelector(Selector<S, dynamic> selector, Callback listener) {
    final keys = selector.deps.keys;
    keys.forEach((sk) {
      final sls = this.selectorListeners[sk];
      final v = _SelectorListener(selector: selector, listener: listener);
      if (sls != null) {
        sls.add(v);
      } else {
        this.selectorListeners[sk] = [v];
      }
    });
    var isSubscribed = true;
    return ([UnsubscribeOptions options]) {
      if (!isSubscribed) {
        return;
      }
      keys.forEach((sk) {
        final sla = this.selectorListeners[sk];
        final index = sla.indexWhere(
            (sl) => sl.selector == selector && sl.listener == listener);
        if (index >= 0) {
          sla.removeAt(index);
        }
      });
      if (options != null && options.resetToDefault) {}
      isSubscribed = false;
    };
  }
}

class UnsubscribeOptions {
  final bool resetToDefault;

  UnsubscribeOptions({this.resetToDefault = false});
}

class _SelectorListener<S extends AppStateI> {
  final Selector selector;
  final Callback listener;
  _SelectorListener({
    @required this.selector,
    @required this.listener,
  });
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
