import 'dart:async';

import 'package:dstore/dstore.dart';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/selector.dart';
import "package:dstore/src/middlewares.dart";

typedef Dispatch = dynamic Function(Action action);

typedef Middleware<State extends AppStateI> = dynamic Function(
    Store<State> store, Dispatch next, Action action);

typedef Callback = dynamic Function();

typedef SelectorUnSubscribeFn = dynamic Function(UnSubscribeOptions? options);

class Store<S extends AppStateI> {
  final Map<String, PStateMeta<PStateModel>> meta;
  final Map<String, List<_SelectorListener>> selectorListeners = {};
  late final List<Dispatch> _dispatchers;
  final Map<int, String> _pStateGroupToStateKeyMap = {};
  final Map<String, Timer> internalDebounceTimers = {};
  late S _state;
  var isReady = false;
  final StorageOptions? storageOptions;
  void Function()? _onReadyListener = null;
  final NetworkOptions? networkOptions;

  Store(
      {required this.meta,
      this.storageOptions,
      this.networkOptions,
      required S Function() stateCreator,
      List<Middleware<S>>? middlewares,
      S? initialState}) {
    middlewares ??= [];
    middlewares.add(asyncMiddleware);
    _dispatchers = _createDispatchers(middlewares);
    if (storageOptions != null) {
      _prepareStoreFromStorage(stateCreator);
    } else {
      _prepareNormalStore(stateCreator);
    }
  }

  void listenForReadyState(Function() fn) {
    _onReadyListener = fn;
  }

  S get state => _state;

  void _prepareStoreFromStorage(S Function() stateCreator) async {
    try {
      final so = storageOptions!;
      final sState = await so.storage.getState(meta.keys);
      if (sState == null) {
        // meaning running app first time or user deleted app data
        _prepareNormalStore(stateCreator);
      } else {
        final AppStateI s = stateCreator();
        final map = <String, dynamic>{};
        meta.forEach((key, rg) {
          if (_pStateGroupToStateKeyMap[rg.group] != null) {
            throw Exception(
                "You already selected same PState before with key ${_pStateGroupToStateKeyMap[rg.group]}  ");
          }
          _pStateGroupToStateKeyMap[rg.group] = key;
          final ds = rg.ds();
          map[key] = sState[key] != null ? ds.copyWithMap(sState[key]!) : ds;
        });
        _state = s.copyWithMap(map);
      }
    } finally {
      isReady = true;
      _onReadyListener?.call();
    }
  }

  void _prepareNormalStore(S Function() stateCreator) {
    final AppStateI s = stateCreator();
    final map = <String, dynamic>{};
    meta.forEach((key, rg) {
      if (_pStateGroupToStateKeyMap[rg.group] != null) {
        throw Exception(
            "You already selected same PState before with key ${_pStateGroupToStateKeyMap[rg.group]}  ");
      }
      _pStateGroupToStateKeyMap[rg.group] = key;
      map[key] = rg.ds();
    });
    _state = s.copyWithMap(map);
    isReady = true;
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
    final sk = _pStateGroupToStateKeyMap[action.group]!;
    final psm = meta[sk]!;
    final gsMap = _state.toMap();
    final currentS = gsMap[sk]!;
    var newS = currentS;
    if (action.isProcessed) {
      // processed by middlewares
      if (action.internal?.type == ActionInternalType.DATA) {
        final csMap = currentS.toMap();
        csMap[action.name] = action.internal!.data;
        newS = currentS.copyWithMap(csMap);
      } else if (action.internal!.type == ActionInternalType.STATE) {
        newS = action.internal!.data;
      }
    } else {
      newS = psm.reducer!(currentS, action);
    }
    if (!identical(newS, currentS)) {
      gsMap[sk] = newS;
      _state = _state.copyWithMap(gsMap);
      _notifyListeners(
          stateKey: sk, previousState: currentS, currentState: newS);
    }
  }

  void _notifyListeners(
      {required String stateKey,
      required PStateModel previousState,
      required PStateModel currentState}) {
    final ls = selectorListeners[stateKey];
    final psMap = previousState.toMap();
    final csMap = currentState.toMap();
    if (ls != null) {
      ls.forEach((sl) {
        if (_isSelectorDependenciesChanged(
            selector: sl.selector as Selector<S, dynamic>,
            prevState: psMap,
            currentState: csMap,
            stateKey: stateKey)) {
          sl.listener();
        }
      });
    }
  }

  bool _isSelectorDependenciesChanged(
      {required Selector<S, dynamic> selector,
      required Map<String, dynamic> prevState,
      required Map<String, dynamic> currentState,
      required String stateKey}) {
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

  void _closeStreams(Selector selector, Map<String, PStateModel> sMap) {
    if (selector.sfDeps != null) {
      // selector.sfDeps!.forEach((key, values) {
      //   final slsa = selectorListeners[key];
      //   final propsOfKeysToCloseStreams = <String, List<String>>{};
      //   if (slsa != null && slsa.isNotEmpty) {
      //     final existingStateKeyProps = <String>{};
      //     slsa.forEach((sls) {
      //       existingStateKeyProps.addAll(sls.selector.deps[key]!);
      //     });
      //     propsOfKeysToCloseStreams[key] = [];
      //     values.forEach((skp) {
      //       if (!existingStateKeyProps.contains(skp)) {
      //         propsOfKeysToCloseStreams[key]!.add(skp);
      //       }
      //     });
      //   } else {
      //     propsOfKeysToCloseStreams[key] = values;
      //   }
      //   propsOfKeysToCloseStreams.forEach((key, props) {
      //     if (props.isNotEmpty) {
      //       final pm = sMap[key]!;
      //       final pmMap = pm.toMap();
      //       // final rmDSMap = meta[sk]!.ds().toMap();
      //       props.forEach((prop) {
      //         final sf = pmMap[prop] as StreamField;
      //         sf.internalSubscription?.cancel();
      //         pmMap[prop] = StreamField();
      //       });
      //       sMap[key] = pm.copyWithMap(pmMap);
      //     }
      //   });
      // });
    }
  }

  void _closeWebSockets(Selector selector, Map<String, PStateModel> sMap) {
    if (selector.sfDeps != null) {
      // selector.sfDeps!.forEach((key, values) {
      //   final slsa = selectorListeners[key];
      //   final propsOfKeysToCloseWebSockets = <String, List<String>>{};
      //   if (slsa != null && slsa.isNotEmpty) {
      //     final existingStateKeyProps = <String>{};
      //     slsa.forEach((sls) {
      //       existingStateKeyProps.addAll(sls.selector.deps[key]!);
      //     });
      //     propsOfKeysToCloseWebSockets[key] = [];
      //     values.forEach((skp) {
      //       if (!existingStateKeyProps.contains(skp)) {
      //         propsOfKeysToCloseWebSockets[key]!.add(skp);
      //       }
      //     });
      //   } else {
      //     propsOfKeysToCloseWebSockets[key] = values;
      //   }
      //   propsOfKeysToCloseWebSockets.forEach((key, props) {
      //     if (props.isNotEmpty) {
      //       final pm = sMap[key]!;
      //       final pmMap = pm.toMap();
      //       props.forEach((prop) {
      //         final wf = pmMap[prop] as WebSocketField;
      //         wf.internalUnsubscribe?.call();
      //         pmMap[prop] = WebSocketField();
      //       });
      //       sMap[key] = pm.copyWithMap(pmMap);
      //     }
      //   });
      // });
    }
  }

  void _resetToDefaultStateIfNotUsedByOtherSelectors(
      Selector selector, Map<String, PStateModel> sMap) {
    final keysToReset = <String>[];
    final propsOfKeysToReset = <String, List<String>>{};
    selector.deps.forEach((sk, values) {
      final slsa = selectorListeners[sk];
      if (slsa != null && slsa.isNotEmpty) {
        final existingStateKeyProps = <String>{};
        slsa.forEach((sls) {
          existingStateKeyProps.addAll(sls.selector.deps[sk]!);
        });
        propsOfKeysToReset[sk] = [];
        values.forEach((skp) {
          if (!existingStateKeyProps.contains(skp)) {
            propsOfKeysToReset[sk]!.add(skp);
          }
        });
      } else {
        // no listeneres for this state key
        keysToReset.add(sk);
      }

      keysToReset.forEach((sk) {
        sMap[sk] = meta[sk]!.ds();
      });
      propsOfKeysToReset.forEach((sk, props) {
        if (props.isNotEmpty) {
          final rm = sMap[sk]!;
          final rmMap = rm.toMap();
          final rmDSMap = meta[sk]!.ds().toMap();
          props.forEach((prop) {
            rmMap[prop] = rmDSMap[prop];
          });
          sMap[sk] = rm.copyWithMap(rmMap);
        }
      });
    });
  }

  void _handleUnsubscribe(Selector selector, UnSubscribeOptions? options) {
    final process = selector.wsDeps != null ||
        selector.sfDeps != null ||
        (options != null && options.resetToDefault != null);
    if (process) {
      final sMap = _state.toMap();
      final isForceReset = options?.resetToDefault == ResetToDefault.FORCE;
      //   _closeStreams(selector, sMap);
      //   _closeWebSockets(selector, sMap);
      //   if (options != null && options.resetToDefault) {
      //     _resetToDefaultStateIfNotUsedByOtherSelectors(selector, sMap);
      //   }
      //   _state = _state.copyWithMap(sMap);
      if (isForceReset) {
      } else {
        final keysToReset = <String>[];
        final propsOfKeysToReset = <String, List<String>>{};
        selector.deps.forEach((sk, values) {
          final slsa = selectorListeners[sk];
          if (slsa != null && slsa.isNotEmpty) {
            final existingStateKeyProps = <String>{};
            slsa.forEach((sls) {
              existingStateKeyProps.addAll(sls.selector.deps[sk]!);
            });
            propsOfKeysToReset[sk] = [];
            values.forEach((skp) {
              if (!existingStateKeyProps.contains(skp)) {
                propsOfKeysToReset[sk]!.add(skp);
              }
            });
          } else {}

          // keysToReset.forEach((sk) {
          //   sMap[sk] = meta[sk]!.ds();
          // });
          // propsOfKeysToReset.forEach((sk, props) {
          //   if (props.isNotEmpty) {
          //     final rm = sMap[sk]!;
          //     final rmMap = rm.toMap();
          //     final rmDSMap = meta[sk]!.ds().toMap();
          //     props.forEach((prop) {
          //       rmMap[prop] = rmDSMap[prop];
          //     });
          //     sMap[sk] = rm.copyWithMap(rmMap);
          //   }
          // });
        });
      }
      // }

    }
  }

  /* public methods  */

  String getStateKeyForReducerGroup(int key) {
    return _pStateGroupToStateKeyMap[key]!;
  }

  dynamic getFieldFromAction(Action action) {
    final sk = _pStateGroupToStateKeyMap[action.group];
    final gsMap = state.toMap();
    final currentS = gsMap[sk]!;
    return currentS.toMap()[action.name];
  }

  PStateMeta getPStateMetaFromAction(Action action) {
    final sk = _pStateGroupToStateKeyMap[action.group];
    return meta[sk]!;
  }

  dynamic dispatch(Action action) {
    _dispatchers[0](action);
  }

  SelectorUnSubscribeFn subscribeSelector(
      Selector<dynamic, dynamic> selector, Callback listener) {
    final keys = selector.deps.keys;
    keys.forEach((sk) {
      final sls = selectorListeners[sk];
      final v = _SelectorListener(selector: selector, listener: listener);
      print("sls $sls");
      if (sls != null) {
        sls.add(v);
      } else {
        print("selector added $sk");
        selectorListeners[sk] = [v];
      }
    });
    var isSubscribed = true;
    return ([UnSubscribeOptions? options]) {
      if (!isSubscribed) {
        return;
      }
      keys.forEach((sk) {
        final sla = selectorListeners[sk]!;
        final index = sla.indexWhere(
            (sl) => sl.selector == selector && sl.listener == listener);
        if (index >= 0) {
          sla.removeAt(index);
        }
      });
      // if (options != null && options.resetToDefault) {
      //   _resetToDefaultStateIfNotUsedByOtherSelectors(
      //       selector as Selector<S, dynamic>);
      // } else {}
      _handleUnsubscribe(selector, options);
      isSubscribed = false;
    };
  }
}

enum ResetToDefault { FORCE, IF_NOT_USED_BY_OTHER_WIDGETS }

class UnSubscribeOptions {
  final ResetToDefault? resetToDefault;

  UnSubscribeOptions({this.resetToDefault});
}

class _SelectorListener<S extends AppStateI> {
  final Selector selector;
  final Callback listener;
  _SelectorListener({
    required this.selector,
    required this.listener,
  });
}

abstract class AppStateI<S> {
  S copyWithMap(Map<String, dynamic> map);
  Map<String, PStateModel> toMap();
}
