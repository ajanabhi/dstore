// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class Sample implements PStateModel<Sample> {
  final String name;

  final int age;

  final List<String> list;

  _$SampleCopyWith<Sample> get copyWith =>
      __$SampleCopyWithImpl<Sample>(this, IdentityFn);

  const Sample({this.name = "hello", this.age = 0, this.list = const []});

  @override
  Sample copyWithMap(Map<String, dynamic> map) => Sample(
      name: map.containsKey("name") ? map["name"] : this.name,
      age: map.containsKey("age") ? map["age"] : this.age,
      list: map.containsKey("list") ? map["list"] : this.list);

  Map<String, dynamic> toMap() =>
      {"name": this.name, "age": this.age, "list": this.list};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Sample && o.name == name && o.age == age && o.list == list;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ list.hashCode;

  @override
  String toString() =>
      "Sample(name: ${this.name}, age: ${this.age}, list: ${this.list})";
}

abstract class $SampleCopyWith<O> {
  factory $SampleCopyWith(Sample value, O Function(Sample) then) =
      _$SampleCopyWithImpl<O>;
  O call({String name, int age, List<String> list});
}

class _$SampleCopyWithImpl<O> implements $SampleCopyWith<O> {
  final Sample _value;
  final O Function(Sample) _then;
  _$SampleCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? age = dimmutable,
      Object? list = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int,
        list: list == dimmutable ? _value.list : list as List<String>));
  }
}

abstract class _$SampleCopyWith<O> implements $SampleCopyWith<O> {
  factory _$SampleCopyWith(Sample value, O Function(Sample) then) =
      __$SampleCopyWithImpl<O>;
  O call({String name, int age, List<String> list});
}

class __$SampleCopyWithImpl<O> extends _$SampleCopyWithImpl<O>
    implements _$SampleCopyWith<O> {
  __$SampleCopyWithImpl(Sample _value, O Function(Sample) _then)
      : super(_value, (v) => _then(v));

  @override
  Sample get _value => super._value;

  @override
  O call(
      {Object? name = dimmutable,
      Object? age = dimmutable,
      Object? list = dimmutable}) {
    return _then(Sample(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int,
        list: list == dimmutable ? _value.list : list as List<String>));
  }
}

class SampleChangeNameMock implements ToMap {
  final String? name;

  const SampleChangeNameMock({this.name});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (name != null) {
      map["name"] = name;
    }

    return map;
  }
}

class SampleChangeAgeMock implements ToMap {
  final int? age;

  const SampleChangeAgeMock({this.age});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (age != null) {
      map["age"] = age;
    }

    return map;
  }
}

class SampleAddToListMock implements ToMap {
  final List<String>? list;

  const SampleAddToListMock({this.list});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (list != null) {
      map["list"] = list;
    }

    return map;
  }
}

abstract class SampleActions {
  static Action changeName(
      {required String newName, SampleChangeNameMock? mock}) {
    return Action(
        name: "changeName",
        type: "/dstore/test/store/pstates/sample/Sample",
        payload: {"newName": newName},
        mock: mock,
        isAsync: false);
  }

  static Action changeAge({required int newAge, SampleChangeAgeMock? mock}) {
    return Action(
        name: "changeAge",
        type: "/dstore/test/store/pstates/sample/Sample",
        payload: {"newAge": newAge},
        mock: mock,
        isAsync: false);
  }

  static Action addToList({required String item, SampleAddToListMock? mock}) {
    return Action(
        name: "addToList",
        type: "/dstore/test/store/pstates/sample/Sample",
        payload: {"item": item},
        mock: mock,
        isAsync: false);
  }
}

dynamic Sample_SyncReducer(dynamic _DStoreState, Action _DstoreAction) {
  _DStoreState = _DStoreState as Sample;
  final name = _DstoreAction.name;
  switch (name) {
    case "changeName":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
        final newName = _DstoreActionPayload["newName"] as String;

        var _DStore_name = _DStoreState.name;
        _DStore_name = newName;
        return _DStoreState.copyWith(name: _DStore_name);
      }

    case "changeAge":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
        final newAge = _DstoreActionPayload["newAge"] as int;

        var _DStore_age = _DStoreState.age;
        _DStore_age = newAge;
        return _DStoreState.copyWith(age: _DStore_age);
      }

    case "addToList":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
        final item = _DstoreActionPayload["item"] as String;

        var _DStore_list = _DStoreState.list;
        _DStore_list = [..._DStoreState.list, item];
        return _DStoreState.copyWith(list: _DStore_list);
      }

    default:
      {
        return _DStoreState;
      }
  }
}

Sample Sample_DS() => Sample(name: "hello", age: 0, list: []);

final SampleMeta = PStateMeta<Sample>(
    type: "/dstore/test/store/pstates/sample/Sample",
    reducer: Sample_SyncReducer,
    ds: Sample_DS);
