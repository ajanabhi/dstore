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
  final AsyncActionField fint;

  Sample(
      {required this.count,
      required this.s,
      required this.name,
      required this.todos,
      required this.fint});

  Sample copyWith(
          {int? count,
          int? s,
          User? name,
          GetTodos? todos,
          AsyncActionField? fint}) =>
      Sample(
          count: count ?? this.count,
          s: s ?? this.s,
          name: name ?? this.name,
          todos: todos ?? this.todos,
          fint: fint ?? this.fint);

  @override
  Sample copyWithMap(Map<String, dynamic> map) => Sample(
      count: map["count"] ?? this.count,
      s: map["s"] ?? this.s,
      name: map["name"] ?? this.name,
      todos: map["todos"] ?? this.todos,
      fint: map["fint"] ?? this.fint);

  Map<String, dynamic> toMap() => {
        "count": this.count,
        "s": this.s,
        "name": this.name,
        "todos": this.todos,
        "fint": this.fint
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Sample &&
        o.count == count &&
        o.s == s &&
        o.name == name &&
        o.todos == todos &&
        o.fint == fint;
  }

  @override
  int get hashCode =>
      count.hashCode ^
      s.hashCode ^
      name.hashCode ^
      todos.hashCode ^
      fint.hashCode;
}

abstract class SampleActions {
  static Action increment() {
    return Action(name: "increment", group: 536232238, isAsync: false);
  }

  static Action decrement() {
    return Action(name: "decrement", group: 536232238, isAsync: false);
  }

  static Action increment2(
      {required int x,
      required dynamic y,
      int sn = 4,
      dynamic y1,
      dynamic y2}) {
    return Action(
        name: "increment2",
        group: 536232238,
        payload: {"x": x, "y": y, "sn": sn, "y1": y1, "y2": y2},
        isAsync: false);
  }

  static Action increment3(
      {required int x, required dynamic y, int si = 4, dynamic s2 = 3}) {
    return Action(
        name: "increment3",
        group: 536232238,
        payload: {"x": x, "y": y, "si": si, "s2": s2},
        isAsync: false);
  }

  static Action fint() {
    return Action(name: "fint", group: 536232238, isAsync: true);
  }

  static todos(
      {bool abortable = false,
      bool offline = false,
      Map<String, dynamic>? headers,
      Null optimisticResponse}) {
    return Action(
        name: "todos",
        group: 536232238,
        http: HttpPayload(
            abortable: abortable,
            offline: offline,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "",
            method: "GET",
            isGraphql: false,
            inputType: HttpInputType.JSON,
            responseType: HttpResponseType.JSON,
            responseDeserializer: getTodosSerializer,
            errorDeserializer: (err) => err));
  }
}

Sample Sample_SyncReducer(Sample _DStoreState, Action _DstoreAction) {
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
        final _DstoreActionPayload = _DstoreAction.payload!;
        final x = _DstoreActionPayload["x"] as int;
        final y = _DstoreActionPayload["y"] as dynamic;
        final sn = _DstoreActionPayload["sn"] as int;
        final y1 = _DstoreActionPayload["y1"] as dynamic;
        final y2 = _DstoreActionPayload["y2"] as dynamic;

        return _DStoreState.copyWith(count: x);
      }

    case "increment3":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
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
}

Future<Sample> Sample_AsyncReducer(
    Sample _DStoreState, Action _DstoreAction) async {
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
}

Sample Sample_DS() => Sample(
    count: 0, s: 0, name: User(), todos: GetTodos(), fint: AsyncActionField());
const SampleMeta = PStateMeta<Sample>(
    group: 536232238,
    reducer: Sample_SyncReducer,
    aReducer: Sample_AsyncReducer,
    ds: Sample_DS);
