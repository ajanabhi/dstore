// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class Sample implements PStateModel<Sample> {
  final String name;

  final int age;

  final AsyncActionField changeNameAfterDelay;

  _$SampleCopyWith<Sample> get copyWith =>
      __$SampleCopyWithImpl<Sample>(this, IdentityFn);

  const Sample(
      {this.name = "hello",
      this.age = 0,
      this.changeNameAfterDelay = const AsyncActionField()});

  @override
  Sample copyWithMap(Map<String, dynamic> map) => Sample(
      name: map.containsKey("name") ? map["name"] : this.name,
      age: map.containsKey("age") ? map["age"] : this.age,
      changeNameAfterDelay: map.containsKey("changeNameAfterDelay")
          ? map["changeNameAfterDelay"]
          : this.changeNameAfterDelay);

  Map<String, dynamic> toMap() => {
        "name": this.name,
        "age": this.age,
        "changeNameAfterDelay": this.changeNameAfterDelay
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Sample &&
        o.name == name &&
        o.age == age &&
        o.changeNameAfterDelay == changeNameAfterDelay;
  }

  @override
  int get hashCode =>
      name.hashCode ^ age.hashCode ^ changeNameAfterDelay.hashCode;

  @override
  String toString() =>
      "Sample(name: ${this.name}, age: ${this.age}, changeNameAfterDelay: ${this.changeNameAfterDelay})";
}

abstract class $SampleCopyWith<O> {
  factory $SampleCopyWith(Sample value, O Function(Sample) then) =
      _$SampleCopyWithImpl<O>;
  O call({String name, int age, AsyncActionField changeNameAfterDelay});
}

class _$SampleCopyWithImpl<O> implements $SampleCopyWith<O> {
  final Sample _value;
  final O Function(Sample) _then;
  _$SampleCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? age = dimmutable,
      Object? changeNameAfterDelay = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int,
        changeNameAfterDelay: changeNameAfterDelay == dimmutable
            ? _value.changeNameAfterDelay
            : changeNameAfterDelay as AsyncActionField));
  }
}

abstract class _$SampleCopyWith<O> implements $SampleCopyWith<O> {
  factory _$SampleCopyWith(Sample value, O Function(Sample) then) =
      __$SampleCopyWithImpl<O>;
  O call({String name, int age, AsyncActionField changeNameAfterDelay});
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
      Object? changeNameAfterDelay = dimmutable}) {
    return _then(Sample(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int,
        changeNameAfterDelay: changeNameAfterDelay == dimmutable
            ? _value.changeNameAfterDelay
            : changeNameAfterDelay as AsyncActionField));
  }
}

abstract class SampleActions {
  static Action changeName({required String newName}) {
    return Action(
        name: "changeName",
        type: "/dstore/test/store/pstates/sample/Sample",
        payload: {"newName": newName},
        isAsync: false);
  }

  static Action changeAge({required int newAge}) {
    return Action(
        name: "changeAge",
        type: "/dstore/test/store/pstates/sample/Sample",
        payload: {"newAge": newAge},
        isAsync: false);
  }

  static Action changeNameAfterDelay(
      {required String newName, Duration? debounce}) {
    return Action(
        name: "changeNameAfterDelay",
        type: "/dstore/test/store/pstates/sample/Sample",
        payload: {"newName": newName},
        isAsync: true,
        debounce: debounce);
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
    case "changeNameAfterDelay":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
        final newName = _DstoreActionPayload["newName"] as String;

        var _DStore_name = _DStoreState.name;
        await Future.delayed(Duration(seconds: 5));
        _DStore_name = newName;
        return _DStoreState.copyWith(name: _DStore_name);
      }

    default:
      {
        return _DStoreState;
      }
  }
}

Sample Sample_DS() =>
    Sample(name: "hello", age: 0, changeNameAfterDelay: AsyncActionField());

final SampleMeta = PStateMeta<Sample>(
    type: "/dstore/test/store/pstates/sample/Sample",
    reducer: Sample_SyncReducer,
    aReducer: Sample_AsyncReducer,
    ds: Sample_DS);
