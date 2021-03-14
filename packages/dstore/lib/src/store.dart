import 'dart:async';

import 'package:dstore/dstore.dart';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/extensions.dart';
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
  final Map<String, String> _pStateTypeToStateKeyMap = {};
  final Map<String, Timer> internalDebounceTimers = {};
  late S _state;
  var isReady = false;
  final StorageOptions? storageOptions;
  void Function()? _onReadyListener;
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
      final sState = await so.storage.getKeys(meta.keys);
      if (sState == null) {
        // meaning running app first time or user deleted app data
        _prepareNormalStore(stateCreator);
      } else {
        final AppStateI s = stateCreator();
        final map = <String, dynamic>{};
        meta.forEach((key, rg) {
          if (_pStateTypeToStateKeyMap[rg.type] != null) {
            throw Exception(
                "You already selected same PState before with key ${_pStateTypeToStateKeyMap[rg.type]}  ");
          }
          _pStateTypeToStateKeyMap[rg.type] = key;
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
      if (_pStateTypeToStateKeyMap[rg.type] != null) {
        throw Exception(
            "You already selected same PState before with key ${_pStateTypeToStateKeyMap[rg.type]}  ");
      }
      _pStateTypeToStateKeyMap[rg.type] = key;
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
    final sk = _pStateTypeToStateKeyMap[action.type]!;
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

  List<String> _getAllPropertyNamesOfStateKey(String sk) {
    final s = meta[sk]!;
    return s.ds().toMap().keys.toList();
  }

  void _handleUnsubscribe(
      Selector selector, UnSubscribeOptions? options) async {
    final process = selector.wsDeps != null ||
        selector.sfDeps != null ||
        (options != null && options.resetToDefault != null);
    if (process) {
      final sMap = _state.toMap();
      dynamic _getFieldFromStateKey(String stateKey, String prop) {
        final currentS = sMap[stateKey]!;
        return currentS.toMap()[prop];
      }

      Map<String, dynamic> _unsubscribeWsDeps(
          String stateKey, List<String> deps) {
        final result = <String, dynamic>{};
        deps.forEach((prop) {
          final field = _getFieldFromStateKey(stateKey, prop) as WebSocketField;
          field.internalUnsubscribe?.call();
          result[prop] = field.copyWith(internalUnsubscribe: Optional(null));
        });
        return result;
      }

      Map<String, dynamic> _unsubscribeSFDeps(
          String stateKey, List<String> deps) {
        final result = <String, dynamic>{};
        deps.forEach((prop) {
          final field = _getFieldFromStateKey(stateKey, prop) as StreamField;
          field.internalSubscription?.cancel();
          result[prop] = field.copyWith(internalSubscription: null);
        });
        return result;
      }

      Future<void> _updatePersitance(Iterable<String> keys) async {
        if (storageOptions != null) {
          //TODO handle reveret back if store fails or inform user
          final result = <String, dynamic>{};
          keys.forEach((sk) {
            final psMeta = meta[sk]!;
            if (psMeta.sm != null) {
              // this key is persitable
              final value = sMap[sk]!;
              result[sk] = psMeta.sm!.serializer(value);
            }
          });
          await storageOptions!.storage.setAll(result);
        }
      }

      final isForceReset = options?.resetToDefault == ResetToDefault.FORCE;

      if (isForceReset) {
        selector.deps.forEach((sk, value) {
          // unsubscribe before reset
          _unsubscribeSFDeps(sk, selector.sfDeps?.getOrElse(sk, []) ?? []);
          _unsubscribeWsDeps(sk, selector.wsDeps?.getOrElse(sk, []) ?? []);
          final listernsToFire = <Callback>[];
          final lsk = selectorListeners[sk];
          if (value.isEmpty) {
            listernsToFire.addAll(lsk
                    ?.where((element) => element.selector != selector)
                    .map((e) => e.listener) ??
                []);
            sMap[sk] = meta[sk]!.ds();
          } else {
            final valueSet = value.toSet();
            lsk
                ?.where((element) => element.selector != selector)
                .forEach((sls) {
              final lSet = sls.selector.deps[sk]?.toSet() ?? {};
              if (valueSet.intersection(lSet).isNotEmpty) {
                listernsToFire.add(sls.listener);
              }
            });
            final rm = sMap[sk]!;
            final rmMap = rm.toMap();
            final rmDSMap = meta[sk]!.ds().toMap();
            value.forEach((prop) {
              rmMap[prop] = rmDSMap[prop];
            });
            sMap[sk] = rm.copyWithMap(rmMap);
          }
          _updatePersitance(selector.deps.keys);
          listernsToFire.forEach((l) {
            l();
          });
        });
      } else {
        final keysToReset = <String>[];
        final propsOfKeysToReset = <String, List<String>>{};
        final websocketPropsOfKeysToUnsubscribe = <String, List<String>>{};
        final streamPropsOfKeysToUnsubscribe = <String, List<String>>{};
        final stateKeysModified = <String>[];
        selector.deps.forEach((sk, values) {
          final slsa = selectorListeners[sk];
          final webSocketValues = selector.wsDeps?.getOrElse(sk, []) ?? [];
          final streamValues = selector.sfDeps?.getOrElse(sk, []) ?? [];
          if (slsa != null) {
            final existingStateKeyProps = <String>{};
            slsa
                .where((element) => element.selector != selector)
                .forEach((sls) {
              existingStateKeyProps.addAll(sls.selector.deps[sk]!);
            });
            propsOfKeysToReset[sk] = [];

            websocketPropsOfKeysToUnsubscribe[sk] = [];
            streamPropsOfKeysToUnsubscribe[sk] = [];
            if (values.isEmpty) {
              // depnds on all fields
              values = _getAllPropertyNamesOfStateKey(sk);
            }
            values.forEach((skp) {
              if (!existingStateKeyProps.contains(skp)) {
                propsOfKeysToReset[sk]!.add(skp);
                if (webSocketValues.contains(skp)) {
                  websocketPropsOfKeysToUnsubscribe[sk]!.add(skp);
                }
                if (streamValues.contains(skp)) {
                  streamPropsOfKeysToUnsubscribe[sk]!.add(skp);
                }
              }
            });
            if (propsOfKeysToReset[sk]!.isNotEmpty) {
              stateKeysModified.add(sk);
            }
          } else {
            // no listeners
            keysToReset.add(sk);
            stateKeysModified.add(sk);
            websocketPropsOfKeysToUnsubscribe[sk] = webSocketValues;
            streamPropsOfKeysToUnsubscribe[sk] = streamValues;
          }

          if (options?.resetToDefault ==
              ResetToDefault.IF_NOT_USED_BY_OTHER_WIDGETS) {
            // reset close websocket abd stream connections
            keysToReset.forEach((sk) {
              final wsDeps = websocketPropsOfKeysToUnsubscribe[sk]!;
              _unsubscribeWsDeps(sk, wsDeps);
              final sfDeps = streamPropsOfKeysToUnsubscribe[sk]!;
              _unsubscribeSFDeps(sk, sfDeps);
              sMap[sk] = meta[sk]!.ds();
            });
            propsOfKeysToReset.forEach((sk, props) {
              if (props.isNotEmpty) {
                final wsDeps = websocketPropsOfKeysToUnsubscribe[sk]!;
                _unsubscribeWsDeps(sk, wsDeps);
                final sfDeps = streamPropsOfKeysToUnsubscribe[sk]!;
                _unsubscribeSFDeps(sk, sfDeps);
                final rm = sMap[sk]!;
                final rmMap = rm.toMap();
                final rmDSMap = meta[sk]!.ds().toMap();
                props.forEach((prop) {
                  rmMap[prop] = rmDSMap[prop];
                });
                sMap[sk] = rm.copyWithMap(rmMap);
              }
            });
          } else {
            // close websocket and stream subscriptions
            final wsFieldsMapForStateKey = <String, Map<String, dynamic>>{};
            final streamFieldsMapForStateKey = <String, Map<String, dynamic>>{};
            keysToReset.forEach((sk) {
              final wsDeps = websocketPropsOfKeysToUnsubscribe[sk]!;
              wsFieldsMapForStateKey[sk] = _unsubscribeWsDeps(sk, wsDeps);
              final sfDeps = streamPropsOfKeysToUnsubscribe[sk]!;
              streamFieldsMapForStateKey[sk] = _unsubscribeSFDeps(sk, sfDeps);
            });
            propsOfKeysToReset.forEach((sk, props) {
              if (props.isNotEmpty) {
                final wsDeps = websocketPropsOfKeysToUnsubscribe[sk]!;
                wsFieldsMapForStateKey[sk] = _unsubscribeWsDeps(sk, wsDeps);
                final sfDeps = streamPropsOfKeysToUnsubscribe[sk]!;
                streamFieldsMapForStateKey[sk] = _unsubscribeSFDeps(sk, sfDeps);
              }
            });
            selector.deps.keys.forEach((sk) {
              final newMap = {
                ...wsFieldsMapForStateKey.getOrElse(sk, {}),
                ...streamFieldsMapForStateKey.getOrElse(sk, {})
              };
              final ps = sMap[sk]!;
              sMap[sk] = ps.copyWithMap(newMap);
            });
          }
        });
        // if persitance is enabled and following state keys are persitable then update values
        await _updatePersitance(stateKeysModified);
        _state = _state.copyWithMap(sMap);
      }
    }
  }

  /* public methods  */

  String getStateKeyForReducerGroup(String key) {
    return _pStateTypeToStateKeyMap[key]!;
  }

  dynamic getFieldFromAction(Action action) {
    final sk = _pStateTypeToStateKeyMap[action.type];
    final gsMap = state.toMap();
    final currentS = gsMap[sk]!;
    return currentS.toMap()[action.name];
  }

  PStateMeta getPStateMetaFromAction(Action action) {
    final sk = _pStateTypeToStateKeyMap[action.type];
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
