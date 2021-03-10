// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
@JsonSerializable()
class Sample implements PStateModel {
  final int count;

  @excludeThisKeyWhilePersist
  @JsonKey(ignore: true)
  final int s;

  @JsonKey(ignore: true, defaultValue: "sample")
  final String n;

  @excludeThisKeyWhilePersist
  @JsonKey(ignore: true)
  final User name;

  final AsyncActionField fint;

  _$SampleCopyWith<Sample> get copyWith =>
      __$SampleCopyWithImpl<Sample>(this, IdentityFn);

  const Sample(
      {this.count = 0,
      this.s = 0,
      this.n = "hello",
      this.name = const User(name: "first2"),
      this.fint = const AsyncActionField()});

  @override
  Sample copyWithMap(Map<String, dynamic> map) => Sample(
      count: map.containsKey("count") ? map["count"] : this.count,
      s: map.containsKey("s") ? map["s"] : this.s,
      n: map.containsKey("n") ? map["n"] : this.n,
      name: map.containsKey("name") ? map["name"] : this.name,
      fint: map.containsKey("fint") ? map["fint"] : this.fint);

  Map<String, dynamic> toMap() => {
        "count": this.count,
        "s": this.s,
        "n": this.n,
        "name": this.name,
        "fint": this.fint
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Sample &&
        o.count == count &&
        o.s == s &&
        o.n == n &&
        o.name == name &&
        o.fint == fint;
  }

  @override
  int get hashCode =>
      count.hashCode ^ s.hashCode ^ n.hashCode ^ name.hashCode ^ fint.hashCode;

  @override
  String toString() =>
      "Sample(count: ${this.count}, s: ${this.s}, n: ${this.n}, name: ${this.name}, fint: ${this.fint})";

  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);

  Map<String, dynamic> toJson() => _$SampleToJson(this);
}

abstract class $SampleCopyWith<O> {
  factory $SampleCopyWith(Sample value, O Function(Sample) then) =
      _$SampleCopyWithImpl<O>;
  O call({int count, int s, String n, User name, AsyncActionField fint});
}

class _$SampleCopyWithImpl<O> implements $SampleCopyWith<O> {
  final Sample _value;
  final O Function(Sample) _then;
  _$SampleCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? count = dimmutable,
      Object? s = dimmutable,
      Object? n = dimmutable,
      Object? name = dimmutable,
      Object? fint = dimmutable}) {
    return _then(_value.copyWith(
        count: count == dimmutable ? _value.count : count as int,
        s: s == dimmutable ? _value.s : s as int,
        n: n == dimmutable ? _value.n : n as String,
        name: name == dimmutable ? _value.name : name as User,
        fint: fint == dimmutable ? _value.fint : fint as AsyncActionField));
  }
}

abstract class _$SampleCopyWith<O> implements $SampleCopyWith<O> {
  factory _$SampleCopyWith(Sample value, O Function(Sample) then) =
      __$SampleCopyWithImpl<O>;
  O call({int count, int s, String n, User name, AsyncActionField fint});
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
      Object? n = dimmutable,
      Object? name = dimmutable,
      Object? fint = dimmutable}) {
    return _then(Sample(
        count: count == dimmutable ? _value.count : count as int,
        s: s == dimmutable ? _value.s : s as int,
        n: n == dimmutable ? _value.n : n as String,
        name: name == dimmutable ? _value.name : name as User,
        fint: fint == dimmutable ? _value.fint : fint as AsyncActionField));
  }
}

abstract class SampleActions {
  static Action increment() {
    return Action(name: "increment", type: Sample, isAsync: false);
  }

  static Action decrement() {
    return Action(name: "decrement", type: Sample, isAsync: false);
  }

  static Action increment2(
      {required int x,
      required dynamic y,
      int sn = 4,
      dynamic y1,
      dynamic y2}) {
    return Action(
        name: "increment2",
        type: Sample,
        payload: {"x": x, "y": y, "sn": sn, "y1": y1, "y2": y2},
        isAsync: false);
  }

  static Action increment3(
      {required int x, required dynamic y, int si = 4, dynamic s2 = 3}) {
    return Action(
        name: "increment3",
        type: Sample,
        payload: {"x": x, "y": y, "si": si, "s2": s2},
        isAsync: false);
  }

  static Action changeUserName({required String name}) {
    return Action(
        name: "changeUserName",
        type: Sample,
        payload: {"name": name},
        isAsync: false);
  }

  static Action changeS({required int s}) {
    return Action(
        name: "changeS", type: Sample, payload: {"s": s}, isAsync: false);
  }

  static Action fint({Duration? debounce}) {
    return Action(
        name: "fint", type: Sample, isAsync: true, debounce: debounce);
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
    n: "hello",
    name: User(name: "first2"),
    fint: AsyncActionField());

const SampleMeta = PStateMeta<Sample>(
    type: Sample,
    reducer: Sample_SyncReducer,
    aReducer: Sample_AsyncReducer,
    ds: Sample_DS);
