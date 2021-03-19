import 'dart:async';
import 'dart:convert';
import "package:dstore/src/middlewares.dart";
import 'package:dstore/dstore.dart';
import 'package:dstore/src/action.dart';
import 'package:dstore/src/extensions.dart';
import 'package:dstore/src/selector.dart';

typedef Dispatch = dynamic Function(Action action);

typedef Middleware<State extends AppStateI<State>> = dynamic Function(
    Store<State, dynamic> store, Dispatch next, Action action);

typedef Callback = dynamic Function();

typedef VoidCallback = void Function();

typedef SelectorUnSubscribeFn = dynamic Function(UnSubscribeOptions? options);

class Store<S extends AppStateI<S>, AT> {
  final Map<String, PStateMeta<PStateModel>> meta;
  final Map<String, List<_SelectorListener>> selectorListeners = {};
  late final List<Dispatch> _dispatchers;
  final Map<String, String> _pStateTypeToStateKeyMap = {};
  final Map<String, Timer> internalDebounceTimers = {};
  late S _state;
  var isReady = false;
  final StorageOptions<AT>? storageOptions;
  void Function()? _onReadyListener;
  final bool useEqualsComparision;
  late final NetworkOptions? networkOptions;
  late final VoidCallback? _unsubscribeNetworkStatusListener;
  final _offlineActions = <Action>[];
  PersitantStorage<AT>? get storage => storageOptions?.storage;
  Store(
      {required this.meta,
      this.storageOptions,
      this.useEqualsComparision = false,
      NetworkOptions? networkOptions,
      required S Function() stateCreator,
      List<Middleware<S>>? middlewares,
      S? initialState}) {
    middlewares ??= [];
    middlewares.add(asyncMiddleware);
    _dispatchers = _createDispatchers(middlewares);
    _setNetworkOptions(networkOptions);
    if (storageOptions != null) {
      _prepareStoreFromStorage(stateCreator);
    } else {
      _prepareNormalStore(stateCreator);
    }
  }

  void _setNetworkOptions(NetworkOptions? op) {
    networkOptions = op;
    _unsubscribeNetworkStatusListener =
        op?.statusListener.listen(_handleNetworkStatusChange);
  }

  void _handleNetworkStatusChange(bool status) {
    if (status) {
      _processOfflineActions();
    }
  }

  void _processOfflineActions() {
    if (_offlineActions.isNotEmpty) {
      final ac = [..._offlineActions];
      _offlineActions.clear();
      if (storage != null) {
        storage!.saveOfflineActions(null);
      }
      ac.forEach((action) {
        dispatch(action);
      });
    }
  }

  void addOfflineAction(Action action) {
    assert(networkOptions != null);
    _offlineActions.add(action);
    if (storage != null) {
      final json = jsonEncode(_offlineActions.map((e) {
        final psm = getPStateMetaFromAction(e);
        final httpMeta = psm.httpMetaMap?[e.name];
        return e.toJson(httpMeta: httpMeta);
      }));
      storage!.saveOfflineActions(json as AT);
    }
  }

  void listenForReadyState(void Function() fn) {
    _onReadyListener = fn;
  }

  S get state => _state;

  void _prepareStoreFromStorage(S Function() stateCreator) async {
    try {
      final storage = storageOptions!.storage;
      final sState = await storage.getKeys(meta.keys);
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
          map[key] = sState[key] != null
              ? ds.copyWithMap(sState[key]! as Map<String, dynamic>)
              : ds;
        });
        _state = s.copyWithMap(map) as S;
      }
      final offA = await storage.getOfflineActions();
      if (offA != null) {
        final actions =
            (jsonDecode(offA as String) as List<Map<String, dynamic>>).map((e) {
          // final psm = getPStateMetaFromAction(e);
          final sk = _pStateTypeToStateKeyMap[e["type"]]!;
          final psm = meta[sk]!;
          final httpMeta = psm.httpMetaMap?[e["name"]];
          return Action<dynamic>.fromJson(e, httpMeta);
        });
        _offlineActions.addAll(actions);
      }
      isReady = true;
      _onReadyListener?.call();
      _processOfflineActions();
    } catch (e) {
      rethrow;
    }
  }

  void _prepareNormalStore(S Function() stateCreator) {
    final s = stateCreator();
    final map = <String, dynamic>{};
    meta.forEach((key, rg) {
      if (_pStateTypeToStateKeyMap[rg.type] != null) {
        throw Exception(
            "You already selected same PState before with key ${_pStateTypeToStateKeyMap[rg.type]}  ");
      }
      _pStateTypeToStateKeyMap[rg.type] = key;
      map[key] = rg.ds();
    });
    _state = s.copyWithMap(map) as S;
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
        newS = currentS.copyWithMap(csMap) as PStateModel;
      } else if (action.internal!.type == ActionInternalType.STATE) {
        newS = action.internal!.data as PStateModel;
      }
    } else {
      newS = psm.reducer!(currentS, action) as PStateModel;
    }
    if (!identical(newS, currentS)) {
      gsMap[sk] = newS;
      _handleStateChange(
          stateKey: sk,
          previousState: currentS,
          psm: psm,
          action: action,
          newGlobalStateMap: gsMap,
          currentState: newS);
    }
  }

  void _handleStateChange(
      {required String stateKey,
      required PStateModel previousState,
      required PStateMeta psm,
      required Action action,
      required Map<String, dynamic> newGlobalStateMap,
      required PStateModel currentState}) async {
    if (psm.sm != null) {
      assert(storageOptions != null);
      final so = storageOptions!;
      if (so.writeMode == StorageWriteMode.DISKFIRST) {
        try {
          final dynamic data = psm.sm!.serializer(currentState);
          await storage!.set(key: psm.type, value: data);
        } on StorageError catch (e) {
          final sa = await so.onWriteError(e, this, action);
          if (sa == StorageWriteErrorAction.ignore) {
            _state = _state.copyWithMap(newGlobalStateMap) as S;
            _notifyListeners(
                stateKey: stateKey,
                previousState: previousState,
                currentState: currentState);
          }
        } catch (e) {
          rethrow;
        }
      } else {
        _state = _state.copyWithMap(newGlobalStateMap) as S;
        _notifyListeners(
            stateKey: stateKey,
            previousState: previousState,
            currentState: currentState);
        try {
          final dynamic data = psm.sm!.serializer(currentState);
          await storage!.set(key: psm.type, value: data);
        } on StorageError catch (e) {
          final sa = await so.onWriteError(e, this, action);
          if (sa == StorageWriteErrorAction.revert_state_changes) {
            currentState = previousState;
            previousState = currentState;
            newGlobalStateMap[stateKey] = currentState;
            _state = _state.copyWithMap(newGlobalStateMap) as S;
            _notifyListeners(
                stateKey: stateKey,
                previousState: previousState,
                currentState: currentState);
          }
        } catch (e) {
          rethrow;
        }
      }
    } else {
      _state = _state.copyWithMap(newGlobalStateMap) as S;
      _notifyListeners(
          stateKey: stateKey,
          previousState: previousState,
          currentState: currentState);
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
          if (!useEqualsComparision &&
              !identical(prevState[prop], currentState[prop])) {
            result = true;
            break;
          } else if (useEqualsComparision &&
              prevState[prop] != currentState[prop]) {
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

      Future<void> _updatePersitance(
          Iterable<String> keys, List<Callback>? listenrsToFire) async {
        if (storageOptions != null) {
          final so = storageOptions!;
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
          if (result.isNotEmpty) {
            try {
              await storageOptions!.storage.setAll(result);
            } on StorageError catch (e) {
              final sa = await so.onWriteError(e, this,
                  Action<dynamic>(name: "unsubscribe", type: "GeneralStore"));
            } catch (e) {
              rethrow;
            }
          }
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
            sMap[sk] = rm.copyWithMap(rmMap) as PStateModel;
          }
          _updatePersitance(selector.deps.keys, []);
          _state = _state.copyWithMap(sMap) as S;
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
                sMap[sk] = rm.copyWithMap(rmMap) as PStateModel;
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
              final newMap = <String, dynamic>{
                ...wsFieldsMapForStateKey.getOrElse(sk, <String, dynamic>{}),
                ...streamFieldsMapForStateKey.getOrElse(sk, <String, dynamic>{})
              };
              final ps = sMap[sk]!;
              sMap[sk] = ps.copyWithMap(newMap) as PStateModel;
            });
          }
        });
        // if persitance is enabled and following state keys are persitable then update values
        await _updatePersitance(stateKeysModified, []);
        _state = _state.copyWithMap(sMap);
      }
    }
  }

  /* public methods  */

  String getStateKeyForPstateType(String key) {
    return _pStateTypeToStateKeyMap[key]!;
  }

  PStateModel getPStateModelFromAction(Action action) {
    final sk = _pStateTypeToStateKeyMap[action.type]!;
    final gsMap = state.toMap();
    return gsMap[sk]!;
  }

  dynamic getFieldFromAction(Action action) {
    final currentS = getPStateModelFromAction(action);
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
        if (!sls.contains(v)) {
          sls.add(v);
        }
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
      _handleUnsubscribe(selector, options);
      isSubscribed = false;
    };
  }

  void cleanup() {
    _unsubscribeNetworkStatusListener?.call();
  }
}

enum ResetToDefault { FORCE, IF_NOT_USED_BY_OTHER_WIDGETS }

class UnSubscribeOptions {
  final ResetToDefault? resetToDefault;

  UnSubscribeOptions({this.resetToDefault});
}

class _SelectorListener {
  final Selector selector;
  final Callback listener;
  _SelectorListener({
    required this.selector,
    required this.listener,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _SelectorListener &&
        other.selector == selector &&
        other.listener == listener;
  }

  @override
  int get hashCode => selector.hashCode ^ listener.hashCode;
}

abstract class AppStateI<S> {
  S copyWithMap(Map<String, dynamic> map);
  Map<String, PStateModel> toMap();
}
