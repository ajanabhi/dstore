// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

// class Name : _Sample

@immutable
class Sample implements PStateModel {
  final int count;
  final int s;
  final User name;
  final GetTodos todos;

  Sample(
      {@required this.count,
      @required this.s,
      @required this.name,
      @required this.todos});

  Sample copyWith({int count, int s, User name, GetTodos todos}) => Sample(
      count: count ?? this.count,
      s: s ?? this.s,
      name: name ?? this.name,
      todos: todos ?? this.todos);

  Sample copyWithMap(Map<String, dynamic> map) => Sample(
      count: map["count"] ?? this.count,
      s: map["s"] ?? this.s,
      name: map["name"] ?? this.name,
      todos: map["todos"] ?? this.todos);

  Map<String, dynamic> toMap() => {
        "count": this.count,
        "s": this.s,
        "name": this.name,
        "todos": this.todos
      };
}

abstract class SampleActions {
  static increment() {
    return Action(
        name: "increment",
        group: "/dstore_example/lib/src/pstates/sample.dart",
        isAsync: false);
  }

  static decrement() {
    return Action(
        name: "decrement",
        group: "/dstore_example/lib/src/pstates/sample.dart",
        isAsync: false);
  }

  static increment2(
      {@required int x,
      @required dynamic y,
      int sn = 4,
      dynamic y1,
      dynamic y2}) {
    return Action(
        name: "increment2",
        group: "/dstore_example/lib/src/pstates/sample.dart",
        payload: {"x": x, "y": y, "sn": sn, "y1": y1, "y2": y2},
        isAsync: false);
  }

  static increment3(
      {@required int x, @required dynamic y, int si = 4, dynamic s2 = 3}) {
    return Action(
        name: "increment3",
        group: "/dstore_example/lib/src/pstates/sample.dart",
        payload: {"x": x, "y": y, "si": si, "s2": s2},
        isAsync: false);
  }

  static fint() {
    return Action(
        name: "fint",
        group: "/dstore_example/lib/src/pstates/sample.dart",
        isAsync: true);
  }
}

final SampleMeta = PStateMeta<Sample>(
    group: "/dstore_example/lib/src/pstates/sample.dart",
    reducer: (Sample _DStoreState, Action _DstoreAction) {
      final name = _DstoreAction.name;
      switch (name) {
        case "increment":
          {
            var _DStore_count = _DStoreState.count;
            _DStore_count = 6;
            return _DStoreState.copyWith(count: _DStore_count);
          }

        case "decrement":
          {
            return _DStoreState.copyWith(count: 3);
          }

        case "increment2":
          {
            final _DstoreActionPayload = _DstoreAction.payload;
            final x = _DstoreActionPayload["x"] as int;
            final y = _DstoreActionPayload["y"] as dynamic;
            final sn = _DstoreActionPayload["sn"] as int;
            final y1 = _DstoreActionPayload["y1"] as dynamic;
            final y2 = _DstoreActionPayload["y2"] as dynamic;

            return _DStoreState.copyWith(count: x);
          }

        case "increment3":
          {
            final _DstoreActionPayload = _DstoreAction.payload;
            final x = _DstoreActionPayload["x"] as int;
            final y = _DstoreActionPayload["y"] as dynamic;
            final si = _DstoreActionPayload["si"] as int;
            final s2 = _DstoreActionPayload["s2"] as dynamic;

            return _DStoreState.copyWith(count: x);
          }

        default:
          {
            return _DStoreState;
          }
      }
    },
    aReducer: (Sample _DStoreState, Action _DstoreAction) async {
      final name = _DstoreAction.name;
      switch (name) {
        case "fint":
          {
            var _DStore_count = _DStoreState.count;
            await Future.delayed(const Duration(seconds: 1));
            _DStore_count = 5;
            return _DStoreState.copyWith(count: _DStore_count);
          }

        default:
          {
            return _DStoreState;
          }
      }
    },
    ds: Sample(count: 0, s: 0, name: User(), todos: GetTodos()));
