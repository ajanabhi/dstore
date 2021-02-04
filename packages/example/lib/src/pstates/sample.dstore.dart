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

  const Sample(
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

  @override
  String toString() =>
      "Sample(count: ${this.count}, s: ${this.s}, name: ${this.name}, todos: ${this.todos}, fint: ${this.fint})";
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

  static Action changeUserName({required String name}) {
    return Action(
        name: "changeUserName",
        group: 536232238,
        payload: {"name": name},
        isAsync: false);
  }

  static Action changeS({required int s}) {
    return Action(
        name: "changeS", group: 536232238, payload: {"s": s}, isAsync: false);
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

dynamic Sample_SyncReducer(dynamic _DStoreState, Action _DstoreAction) {
  _DStoreState = _DStoreState as Sample;
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

    case "changeUserName":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
        final name = _DstoreActionPayload["name"] as String;

        var _DStore_name = _DStoreState.name;
        _DStore_name = _DStoreState.name.copyWith(name: name);
        return _DStoreState.copyWith(name: _DStore_name);
      }

    case "changeS":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
        final s = _DstoreActionPayload["s"] as int;

        var _DStore_s = _DStoreState.s;
        _DStore_s = s;
        return _DStoreState.copyWith(s: _DStore_s);
      }

    default:
      {
        return _DStoreState;
      }
  }
}

Future<dynamic> Sample_AsyncReducer(
    dynamic _DStoreState, Action _DstoreAction) async {
  _DStoreState = _DStoreState as Sample;
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
    count: 0,
    s: 0,
    name: User(name: "first"),
    todos: GetTodos(),
    fint: AsyncActionField());

const SampleMeta = PStateMeta<Sample>(
    group: 536232238,
    reducer: Sample_SyncReducer,
    aReducer: Sample_AsyncReducer,
    ds: Sample_DS);

// **************************************************************************
// DImmutableGenerator
// **************************************************************************

mixin _$User {
  String get name;

  User copyWith({String? name});
}

class _User implements User {
  @override
  final String name;

  const _User({required this.name});

  @override
  _User copyWith({String? name}) => _User(name: name ?? this.name);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _User && o.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "User(name: ${this.name})";
}

mixin _$P2 {
  String get name;
  int get age;
  int? get a2;

  P2 copyWith({String? name, int? age, Nullable<int>? a2});
}

class _P2 implements P2 {
  @override
  final String name;

  @override
  final int age;

  @override
  final int? a2;

  const _P2({required this.name, required this.age, this.a2});

  @override
  _P2 copyWith({String? name, int? age, Nullable<int>? a2}) => _P2(
      name: name ?? this.name,
      age: age ?? this.age,
      a2: a2 != null ? a2.value : this.a2);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is _P2 && o.name == name && o.age == age && o.a2 == a2;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ a2.hashCode;

  @override
  String toString() =>
      "P2(name: ${this.name}, age: ${this.age}, a2: ${this.a2})";
}
