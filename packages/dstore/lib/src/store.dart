import 'package:dstore/dstore.dart';
import 'package:meta/meta.dart';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/selector.dart';

typedef Dispatch = dynamic Function(Action action);

typedef Middleware<State extends AppStateI> = dynamic Function(
    Store<State> store, Dispatch next, Action action);

typedef Callback = dynamic Function();

typedef SelectorUnSubscribeFn = dynamic Function(UnSubscribeOptions options);

class Store<S extends AppStateI> {
  final Map<String, PStateMeta<PStateModel>> meta;
  final Map<String, List<_SelectorListener>> selectorListeners = {};
  List<Dispatch> _dispatchers;
  Map<String, String> _reducerGroupToStateKeyMap = {};
  S _state;

  Store(
      {@required this.meta,
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
    this.meta.forEach((key, rg) {
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

  dynamic _defaultDispatch(Action action) {
    final sk = this._reducerGroupToStateKeyMap[action.group];
    final psm = this.meta[sk];
    final gsMap = _state.toMap();
    final currentS = gsMap[sk];
    var newS = currentS;
    if (action.isProcessed) {
      // processed by middlewares
      if (action.internal.type == ActionInternalType.DATA) {
        final csMap = currentS.toMap();
        csMap[action.name] = action.internal.data;
        newS = currentS.copyWithMap(csMap);
      } else if (action.internal.type == ActionInternalType.STATE) {
        newS = action.internal.data;
      }
    } else {
      if (action.isAsync) {
        _processAsyncAction(action: action, currentS: currentS, psm: psm);
      } else {
        newS = psm.reducer(currentS, action);
      }
    }
    if (!identical(newS, currentS)) {
      gsMap[sk] = newS;
      _state = _state.copyWithMap(gsMap);
      _notifyListeners(
          stateKey: sk, previousState: currentS, currentState: newS);
    }
  }

  void _processAsyncAction(
      {Action action, PStateMeta psm, dynamic currentS}) async {
    dispatch(action.copyWith(
        internal: ActionInternal(
            processed: true,
            type: ActionInternalType.DATA,
            data: AsyncActionField(loading: true))));
    try {
      final s = await psm.aReducer(currentS, action);
      final asm = s.toMap();
      asm[action.name] = AsyncActionField();
      final newS = s.copyWithMap(asm);
      dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, data: newS, type: ActionInternalType.STATE)));
    } catch (e) {
      dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true,
              type: ActionInternalType.DATA,
              data: AsyncActionField(error: e))));
    }
  }

  void _notifyListeners(
      {@required String stateKey,
      @required PStateModel previousState,
      @required PStateModel currentState}) {
    final ls = this.selectorListeners[stateKey];
    final psMap = previousState.toMap();
    final csMap = currentState.toMap();
    if (ls != null) {
      ls.forEach((sl) {
        if (_isSelectorDependenciesChanged(
            selector: sl.selector,
            prevState: psMap,
            currentState: csMap,
            stateKey: stateKey)) {
          sl.listener();
        }
      });
    }
  }

  bool _isSelectorDependenciesChanged(
      {@required Selector<S, dynamic> selector,
      @required Map<String, dynamic> prevState,
      @required Map<String, dynamic> currentState,
      @required String stateKey}) {
    var result = false;
    selector.deps.forEach((key, value) {
      if (key == stateKey) {
        for (final prop in value) {
          if (!identical(prevState[prop], currentState[prop])) {
            result = true;
            break;
          }
        }
      }
    });
    return result;
  }

  void _resetToDefaultState(Selector<S, dynamic> selector) {
    final keysToReset = <String>[];
    final propsOfKeysToReset = <String, List<String>>{};
    selector.deps.forEach((sk, values) {
      final slsa = this.selectorListeners[sk];
      if (slsa != null && slsa.length > 0) {
        final existingStateKeyProps = <String>{};
        slsa.forEach((sls) {
          existingStateKeyProps.addAll(sls.selector.deps[sk]);
        });
        propsOfKeysToReset[sk] = [];
        values.forEach((skp) {
          if (!existingStateKeyProps.contains(skp)) {
            propsOfKeysToReset[sk].add(skp);
          }
        });
      } else {
        // no listeneres for this state key
        keysToReset.add(sk);
      }
      final sMap = _state.toMap();
      keysToReset.forEach((sk) {
        sMap[sk] = this.meta[sk].ds();
      });
      propsOfKeysToReset.forEach((sk, props) {
        if (props.length > 0) {
          final rm = sMap[sk];
          final rmMap = rm.toMap();
          final rmDSMap = this.meta[sk].ds().toMap();
          props.forEach((prop) {
            rmMap[prop] = rmDSMap[prop];
          });
          sMap[sk] = rm.copyWithMap(rmMap);
        }
      });
      _state = _state.copyWithMap(sMap);
    });
  }

  /* public methods  */

  String getStateKeyForReducerGroup(String key) {
    return this._reducerGroupToStateKeyMap[key];
  }

  dynamic dispatch(Action action) {
    _dispatchers[0](action);
  }

  SelectorUnSubscribeFn subscribeSelector(
      Selector<S, dynamic> selector, Callback listener) {
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
    return ([UnSubscribeOptions options]) {
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
      if (options != null && options.resetToDefault) {
        _resetToDefaultState(selector);
      }
      isSubscribed = false;
    };
  }
}

class UnSubscribeOptions {
  final bool resetToDefault;

  UnSubscribeOptions({this.resetToDefault = false});
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
  Map<String, PStateModel> toMap();
}
