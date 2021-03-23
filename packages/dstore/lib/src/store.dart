import 'dart:async';
import 'dart:convert';
import 'package:dstore/dstore.dart';
import 'package:dstore/src/action.dart';
import 'package:dstore/src/extensions.dart';
import 'package:dstore/src/middlewares/async_middleware.dart';
import 'package:dstore/src/selector.dart';
import 'package:collection/collection.dart';

typedef Dispatch = dynamic Function(Action<dynamic> action);

typedef Middleware<State extends AppStateI<State>> = dynamic Function(
    Store<State, dynamic> store, Dispatch next, Action<dynamic> action);

typedef Callback = dynamic Function();

typedef VoidCallback = void Function();

typedef SelectorUnSubscribeFn = dynamic Function(UnSubscribeOptions? options);

class Store<S extends AppStateI<S>, AT> {
  final Map<String, PStateMeta<PStateModel<dynamic>>> meta;
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
  final _offlineActions = <Action<dynamic>>[];
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

  void addOfflineAction(Action<dynamic> action) {
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
        final AppStateI<S> s = stateCreator();
        final map = <String, PStateModel<dynamic>>{};
        final psDepsMap = <String, PStateModel<dynamic>>{};
        meta.forEach((key, psm) {
          if (_pStateTypeToStateKeyMap[psm.type] != null) {
            throw ArgumentError.value(
                "You already selected same PState before with key ${_pStateTypeToStateKeyMap[psm.type]}  ");
          }
          _pStateTypeToStateKeyMap[psm.type] = key;
          PStateModel<dynamic> ps;
          if (psDepsMap.containsKey(key)) {
            ps = psDepsMap[key]!;
          } else {
            ps = psm.ds();
            final sps = sState[key] as Map<String, dynamic>?;
            if (sps != null) {
              ps = ps.copyWithMap(sps) as PStateModel;
            }
          }

          if (psm.psDeps != null) {
            final psDeps = <PStateModel<dynamic>>[];
            psm.psDeps!.forEach((type) {
              final ek = _pStateTypeToStateKeyMap[type];
              if (ek != null) {
                psDeps.add(map[ek]!);
              } else {
                // default state not calculated before so calculate it now and store it in map and use it later
                final psmI = _getPStateMetaFromType(type);
                var psI = psmI.value.ds();
                final sps = sState[psmI.key] as Map<String, dynamic>?;
                if (sps != null) {
                  psI = psI.copyWithMap(sps) as PStateModel;
                }
                psDepsMap[key] = psI;
                psDeps.add(psI);
              }
            });
            ps.internalSetPSDeps(psDeps);
          }
          final ds = psm.ds();
          map[key] = sState[key] != null
              ? ds.copyWithMap(sState[key]! as Map<String, dynamic>)
                  as PStateModel
              : ds;
        });
        _state = s.copyWithMap(map);
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
    final map = <String, PStateModel<dynamic>>{};
    final psDepsMap = <String, PStateModel<dynamic>>{};
    meta.forEach((key, psm) {
      if (_pStateTypeToStateKeyMap[psm.type] != null) {
        throw ArgumentError.value(
            "You already selected same PState before with key ${_pStateTypeToStateKeyMap[psm.type]}  ");
      }
      _pStateTypeToStateKeyMap[psm.type] = key;
      final ps = psDepsMap[key] ?? psm.ds();
      if (psm.psDeps != null) {
        final psDeps = <PStateModel<dynamic>>[];
        psm.psDeps!.forEach((type) {
          final ek = _pStateTypeToStateKeyMap[type];
          if (ek != null) {
            psDeps.add(map[ek]!);
          } else {
            // default state not calculated before so calculate it now and store it in map and use it later
            final psmI = _getPStateMetaFromType(type);
            final psI = psmI.value.ds();
            psDepsMap[psmI.key] = psI;
            psDeps.add(psI);
          }
        });
        ps.internalSetPSDeps(psDeps);
      }
      map[key] = ps;
    });
    _state = s.copyWithMap(map);
    isReady = true;
  }

  MapEntry<String, PStateMeta> _getPStateMetaFromType(String type) {
    final value = meta.entries.singleWhereOrNull((me) => me.value.type == type);
    if (value == null) {
      throw ArgumentError.value(
          "Looks like you diidnt added $type to AppState");
    }
    return value;
  }

  List<Dispatch> _createDispatchers(List<Middleware<S>> middlewares) {
    final dispatchers = <Dispatch>[]..add(_defaultDispatch);
    middlewares.reversed.forEach((m) {
      final next = dispatchers.last;
      dispatchers.add((Action<dynamic> action) => m(this, next, action));
    });
    return dispatchers.reversed.toList();
  }

  dynamic _defaultDispatch(Action<dynamic> action) {
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
      required PStateModel<dynamic> previousState,
      required PStateMeta psm,
      required Action<dynamic> action,
      required Map<String, dynamic> newGlobalStateMap,
      required PStateModel<dynamic> currentState}) async {
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
            _state = _state.copyWithMap(newGlobalStateMap);
            _notifyListeners(
                stateKey: stateKey,
                previousState: previousState,
                currentState: currentState);
          }
        } catch (e) {
          rethrow;
        }
      } else {
        _state = _state.copyWithMap(newGlobalStateMap);
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
            _state = _state.copyWithMap(newGlobalStateMap);
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
      _state = _state.copyWithMap(newGlobalStateMap);
      _notifyListeners(
          stateKey: stateKey,
          previousState: previousState,
          currentState: currentState);
    }
  }

  void _notifyListeners(
      {required String stateKey,
      required PStateModel<dynamic> previousState,
      required PStateModel<dynamic> currentState}) {
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
    final deps = selector.deps[stateKey];
    if (deps != null) {
      if (deps.isEmpty) {
        result = true;
      } else {
        for (final prop in deps) {
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
    }
    return result;
  }

  List<String> _getAllPropertyNamesOfStateKey(String sk) {
    final s = meta[sk]!;
    return s.ds().toMap().keys.toList();
  }

  void _handleUnsubscribe(
      Selector<S, dynamic> selector, UnSubscribeOptions? options) async {
    final process = selector.wsDeps != null ||
        selector.sfDeps != null ||
        (options != null && options.resetToDefault == true);
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
          slsa.where((element) => element.selector != selector).forEach((sls) {
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

        if (options?.resetToDefault == true) {
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

  /* public methods  */

  String getStateKeyForPstateType(String key) {
    return _pStateTypeToStateKeyMap[key]!;
  }

  PStateModel<dynamic> getPStateModelFromAction(Action<dynamic> action) {
    final sk = _pStateTypeToStateKeyMap[action.type]!;
    final gsMap = state.toMap();
    return gsMap[sk]!;
  }

  dynamic getFieldFromAction(Action<dynamic> action) {
    final currentS = getPStateModelFromAction(action);
    return currentS.toMap()[action.name];
  }

  PStateMeta getPStateMetaFromAction(Action<dynamic> action) {
    final sk = _pStateTypeToStateKeyMap[action.type];
    return meta[sk]!;
  }

  dynamic dispatch(Action<dynamic> action) {
    _dispatchers[0](action);
  }

  SelectorUnSubscribeFn subscribeSelector(
      Selector<S, dynamic> selector, Callback listener) {
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

// enum ResetToDefault { FORCE, IF_NOT_USED_BY_OTHER_WIDGETS }

class UnSubscribeOptions {
  final bool resetToDefault;

  UnSubscribeOptions({this.resetToDefault = false});
}

class _SelectorListener {
  final Selector<dynamic, dynamic> selector;
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
  Map<String, PStateModel<dynamic>> toMap();
}
