// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_history_ps.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class SimpleHistory extends PStateModel<SimpleHistory>
    with PStateHistoryMixin<SimpleHistory> {
  final int count;

  _$SimpleHistoryCopyWith<SimpleHistory> get copyWith =>
      __$SimpleHistoryCopyWithImpl<SimpleHistory>(this, IdentityFn);

  SimpleHistory({this.count = 0});

  @override
  SimpleHistory copyWithMap(Map<String, dynamic> map) => SimpleHistory(
      count: map.containsKey("count") ? map["count"] as int : this.count);

  Map<String, dynamic> toMap() => <String, dynamic>{"count": this.count};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is SimpleHistory && o.count == count;
  }

  @override
  int get hashCode => count.hashCode;

  @override
  String toString() => "SimpleHistory(count: ${this.count})";
}

abstract class $SimpleHistoryCopyWith<O> {
  factory $SimpleHistoryCopyWith(
          SimpleHistory value, O Function(SimpleHistory) then) =
      _$SimpleHistoryCopyWithImpl<O>;
  O call({int count});
}

class _$SimpleHistoryCopyWithImpl<O> implements $SimpleHistoryCopyWith<O> {
  final SimpleHistory _value;
  final O Function(SimpleHistory) _then;
  _$SimpleHistoryCopyWithImpl(this._value, this._then);

  @override
  O call({Object? count = dimmutable}) {
    return _then(_value.copyWith(
        count: count == dimmutable ? _value.count : count as int));
  }
}

abstract class _$SimpleHistoryCopyWith<O> implements $SimpleHistoryCopyWith<O> {
  factory _$SimpleHistoryCopyWith(
          SimpleHistory value, O Function(SimpleHistory) then) =
      __$SimpleHistoryCopyWithImpl<O>;
  O call({int count});
}

class __$SimpleHistoryCopyWithImpl<O> extends _$SimpleHistoryCopyWithImpl<O>
    implements _$SimpleHistoryCopyWith<O> {
  __$SimpleHistoryCopyWithImpl(
      SimpleHistory _value, O Function(SimpleHistory) _then)
      : super(_value, (v) => _then(v));

  @override
  SimpleHistory get _value => super._value;

  @override
  O call({Object? count = dimmutable}) {
    return _then(SimpleHistory(
        count: count == dimmutable ? _value.count : count as int));
  }
}

const _SimpleHistory_FullPath =
    "/store/pstates/simple_history_ps/SimpleHistory";

class SimpleHistoryIncrementResult
    implements ToMap<SimpleHistoryIncrementResult> {
  final int? count;

  const SimpleHistoryIncrementResult({this.count});
  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (count != null) {
      map["count"] = count;
    }

    return map;
  }

  @override
  SimpleHistoryIncrementResult copyWithMap(Map<String, dynamic> map) =>
      throw UnimplementedError();
}

class SimpleHistoryDecrementResult
    implements ToMap<SimpleHistoryDecrementResult> {
  final int? count;

  const SimpleHistoryDecrementResult({this.count});
  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (count != null) {
      map["count"] = count;
    }

    return map;
  }

  @override
  SimpleHistoryDecrementResult copyWithMap(Map<String, dynamic> map) =>
      throw UnimplementedError();
}

abstract class SimpleHistoryActions {
  static Action<SimpleHistoryIncrementResult> increment({bool silent = false}) {
    return Action<SimpleHistoryIncrementResult>(
        name: "increment",
        silent: silent,
        type: _SimpleHistory_FullPath,
        psHistoryPayload: PSHistoryPayload(keysModified: ["count"]),
        isAsync: false);
  }

  static Action<SimpleHistoryIncrementResult> incrementMock(
      SimpleHistoryIncrementResult mock) {
    return Action<SimpleHistoryIncrementResult>(
        name: "increment",
        type: _SimpleHistory_FullPath,
        mock: mock,
        psHistoryPayload: PSHistoryPayload(keysModified: ["count"]));
  }

  static Action<SimpleHistoryDecrementResult> decrement({bool silent = false}) {
    return Action<SimpleHistoryDecrementResult>(
        name: "decrement",
        silent: silent,
        type: _SimpleHistory_FullPath,
        psHistoryPayload: PSHistoryPayload(keysModified: ["count"]),
        isAsync: false);
  }

  static Action<SimpleHistoryDecrementResult> decrementMock(
      SimpleHistoryDecrementResult mock) {
    return Action<SimpleHistoryDecrementResult>(
        name: "decrement",
        type: _SimpleHistory_FullPath,
        mock: mock,
        psHistoryPayload: PSHistoryPayload(keysModified: ["count"]));
  }

  static Action<dynamic> undo() {
    return Action<dynamic>(
        name: "undo",
        type: _SimpleHistory_FullPath,
        psHistoryPayload: PSHistoryPayload(keysModified: []));
  }

  static Action<dynamic> redo() {
    return Action<dynamic>(
        name: "redo",
        type: _SimpleHistory_FullPath,
        psHistoryPayload: PSHistoryPayload(keysModified: []));
  }

  static Action<dynamic> clearHistory() {
    return Action<dynamic>(
        name: "clearHistory",
        type: _SimpleHistory_FullPath,
        psHistoryPayload: PSHistoryPayload(keysModified: []));
  }
}

dynamic SimpleHistory_SyncReducer(dynamic _DStoreState, Action _DstoreAction) {
  _DStoreState = _DStoreState as SimpleHistory;
  final name = _DstoreAction.name;
  switch (name) {
    case "increment":
      {
        var _DStore_count = _DStoreState.count;
        _DStore_count += 1;
        final newState = _DStoreState.copyWith(count: _DStore_count);
        newState.dontTouchMePSHistory = _DStoreState.dontTouchMePSHistory;

        return newState;
      }

    case "decrement":
      {
        var _DStore_count = _DStoreState.count;
        _DStore_count -= 1;
        final newState = _DStoreState.copyWith(count: _DStore_count);
        newState.dontTouchMePSHistory = _DStoreState.dontTouchMePSHistory;

        return newState;
      }

    default:
      {
        return _DStoreState;
      }
  }
}

SimpleHistory SimpleHistory_DS() {
  final state = SimpleHistory(count: 0);
  state.dontTouchMePSHistory = PStateHistory<SimpleHistory>(null);

  return state;
}

final SimpleHistoryMeta = PStateMeta<SimpleHistory>(
    type: _SimpleHistory_FullPath,
    reducer: SimpleHistory_SyncReducer,
    ds: SimpleHistory_DS,
    enableHistory: true,
    actionsMeta: {
      "increment": ["count"],
      "decrement": ["count"]
    });
