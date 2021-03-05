// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

// class Name : $Sample

@immutable
class Sample implements PStateModel {
  final int count;

  final int s;

  final User name;

  final GetTodos todos;

  final StreamField sf;

  final WsMessage wm;

  final AsyncActionField fint;

  _$SampleCopyWith<Sample> get copyWith =>
      __$SampleCopyWithImpl<Sample>(this, IdentityFn);

  const Sample(
      {this.count = 0,
      this.s = 0,
      this.name = User(name: "first"),
      this.todos = GetTodos(),
      this.sf = StreamField(),
      this.wm = WsMessage(),
      this.fint = AsyncActionField()});

  @override
  Sample copyWithMap(Map<String, dynamic> map) => Sample(
      count: map["count"] ?? this.count,
      s: map["s"] ?? this.s,
      name: map["name"] ?? this.name,
      todos: map["todos"] ?? this.todos,
      sf: map["sf"] ?? this.sf,
      wm: map["wm"] ?? this.wm,
      fint: map["fint"] ?? this.fint);

  Map<String, dynamic> toMap() => {
        "count": this.count,
        "s": this.s,
        "name": this.name,
        "todos": this.todos,
        "sf": this.sf,
        "wm": this.wm,
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
        o.sf == sf &&
        o.wm == wm &&
        o.fint == fint;
  }

  @override
  int get hashCode =>
      count.hashCode ^
      s.hashCode ^
      name.hashCode ^
      todos.hashCode ^
      sf.hashCode ^
      wm.hashCode ^
      fint.hashCode;

  @override
  String toString() =>
      "Sample(count: ${this.count}, s: ${this.s}, name: ${this.name}, todos: ${this.todos}, sf: ${this.sf}, wm: ${this.wm}, fint: ${this.fint})";
}

abstract class $SampleCopyWith<O> {
  factory $SampleCopyWith(Sample value, O Function(Sample) then) =
      _$SampleCopyWithImpl<O>;
  O call(
      {int count,
      int s,
      User name,
      GetTodos todos,
      StreamField sf,
      WsMessage wm,
      AsyncActionField fint});
}

class _$SampleCopyWithImpl<O> implements $SampleCopyWith<O> {
  final Sample _value;
  final O Function(Sample) _then;
  _$SampleCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? count = dimmutable,
      Object? s = dimmutable,
      Object? name = dimmutable,
      Object? todos = dimmutable,
      Object? sf = dimmutable,
      Object? wm = dimmutable,
      Object? fint = dimmutable}) {
    return _then(_value.copyWith(
        count: count == dimmutable ? _value.count : count as int,
        s: s == dimmutable ? _value.s : s as int,
        name: name == dimmutable ? _value.name : name as User,
        todos: todos == dimmutable ? _value.todos : todos as GetTodos,
        sf: sf == dimmutable ? _value.sf : sf as StreamField,
        wm: wm == dimmutable ? _value.wm : wm as WsMessage,
        fint: fint == dimmutable ? _value.fint : fint as AsyncActionField));
  }
}

abstract class _$SampleCopyWith<O> implements $SampleCopyWith<O> {
  factory _$SampleCopyWith(Sample value, O Function(Sample) then) =
      __$SampleCopyWithImpl<O>;
  O call(
      {int count,
      int s,
      User name,
      GetTodos todos,
      StreamField sf,
      WsMessage wm,
      AsyncActionField fint});
}

class __$SampleCopyWithImpl<O> extends _$SampleCopyWithImpl<O>
    implements _$SampleCopyWith<O> {
  __$SampleCopyWithImpl(Sample _value, O Function(Sample) _then)
      : super(_value, (v) => _then(v));

  @override
  Sample get _value => super._value;

  @override
  O call(
      {Object? count = dimmutable,
      Object? s = dimmutable,
      Object? name = dimmutable,
      Object? todos = dimmutable,
      Object? sf = dimmutable,
      Object? wm = dimmutable,
      Object? fint = dimmutable}) {
    return _then(Sample(
        count: count == dimmutable ? _value.count : count as int,
        s: s == dimmutable ? _value.s : s as int,
        name: name == dimmutable ? _value.name : name as User,
        todos: todos == dimmutable ? _value.todos : todos as GetTodos,
        sf: sf == dimmutable ? _value.sf : sf as StreamField,
        wm: wm == dimmutable ? _value.wm : wm as WsMessage,
        fint: fint == dimmutable ? _value.fint : fint as AsyncActionField));
  }
}

abstract class SampleActions {
  static Action increment() {
    return Action(name: "increment", group: 240344394, isAsync: false);
  }

  static Action decrement() {
    return Action(name: "decrement", group: 240344394, isAsync: false);
  }

  static Action increment2(
      {required int x,
      required dynamic y,
      int sn = 4,
      dynamic y1,
      dynamic y2}) {
    return Action(
        name: "increment2",
        group: 240344394,
        payload: {"x": x, "y": y, "sn": sn, "y1": y1, "y2": y2},
        isAsync: false);
  }

  static Action increment3(
      {required int x, required dynamic y, int si = 4, dynamic s2 = 3}) {
    return Action(
        name: "increment3",
        group: 240344394,
        payload: {"x": x, "y": y, "si": si, "s2": s2},
        isAsync: false);
  }

  static Action changeUserName({required String name}) {
    return Action(
        name: "changeUserName",
        group: 240344394,
        payload: {"name": name},
        isAsync: false);
  }

  static Action changeS({required int s}) {
    return Action(
        name: "changeS", group: 240344394, payload: {"s": s}, isAsync: false);
  }

  static Action fint({Duration? debounce}) {
    return Action(
        name: "fint", group: 240344394, isAsync: true, debounce: debounce);
  }

  static todos(
      {bool abortable = false,
      Map<String, dynamic>? headers,
      Null optimisticResponse,
      Duration? debounce}) {
    return Action(
        name: "todos",
        group: 240344394,
        http: HttpPayload(
            abortable: abortable,
            headers: headers,
            optimisticResponse: optimisticResponse,
            url: "",
            method: "GET",
            inputType: HttpInputType.JSON,
            responseType: HttpResponseType.JSON),
        debounce: debounce);
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
    sf: StreamField(),
    wm: WsMessage(),
    fint: AsyncActionField());

const SampleMeta = PStateMeta<Sample>(
    group: 240344394,
    reducer: Sample_SyncReducer,
    aReducer: Sample_AsyncReducer,
    ds: Sample_DS);
