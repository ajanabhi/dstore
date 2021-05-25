// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class Sample extends PStateModel<Sample> with PStateStoreDepsMixin {
  final String name;

  final int age;

  final StreamField<int, Object> intStream;

  final List<String> list;

  final bool isDark;

  final AsyncActionField changeTheme;

  Sample2 get s => dontTouchMeStore.state.s as Sample2;

  _$SampleCopyWith<Sample> get copyWith =>
      __$SampleCopyWithImpl<Sample>(this, IdentityFn);

  Sample(
      {this.name = "hello",
      this.age = 0,
      this.intStream = const StreamField(),
      this.list = const [],
      this.isDark = false,
      this.changeTheme = const AsyncActionField()});

  @override
  Sample copyWithMap(Map<String, dynamic> map) => Sample(
      name: map.containsKey("name") ? map["name"] as String : this.name,
      age: map.containsKey("age") ? map["age"] as int : this.age,
      intStream: map.containsKey("intStream")
          ? map["intStream"] as StreamField<int, Object>
          : this.intStream,
      list: map.containsKey("list") ? map["list"] as List<String> : this.list,
      isDark: map.containsKey("isDark") ? map["isDark"] as bool : this.isDark,
      changeTheme: map.containsKey("changeTheme")
          ? map["changeTheme"] as AsyncActionField
          : this.changeTheme);

  Map<String, dynamic> toMap() => <String, dynamic>{
        "name": this.name,
        "age": this.age,
        "intStream": this.intStream,
        "list": this.list,
        "isDark": this.isDark,
        "changeTheme": this.changeTheme
      };

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Sample &&
        o.name == name &&
        o.age == age &&
        o.intStream == intStream &&
        o.list == list &&
        o.isDark == isDark &&
        o.changeTheme == changeTheme;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      age.hashCode ^
      intStream.hashCode ^
      list.hashCode ^
      isDark.hashCode ^
      changeTheme.hashCode;

  @override
  String toString() =>
      "Sample(name: ${this.name}, age: ${this.age}, intStream: ${this.intStream}, list: ${this.list}, isDark: ${this.isDark}, changeTheme: ${this.changeTheme})";
}

abstract class $SampleCopyWith<O> {
  factory $SampleCopyWith(Sample value, O Function(Sample) then) =
      _$SampleCopyWithImpl<O>;
  O call(
      {String name,
      int age,
      StreamField<int, Object> intStream,
      List<String> list,
      bool isDark,
      AsyncActionField changeTheme});
}

class _$SampleCopyWithImpl<O> implements $SampleCopyWith<O> {
  final Sample _value;
  final O Function(Sample) _then;
  _$SampleCopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? name = dimmutable,
      Object? age = dimmutable,
      Object? intStream = dimmutable,
      Object? list = dimmutable,
      Object? isDark = dimmutable,
      Object? changeTheme = dimmutable}) {
    return _then(_value.copyWith(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int,
        intStream: intStream == dimmutable
            ? _value.intStream
            : intStream as StreamField<int, Object>,
        list: list == dimmutable ? _value.list : list as List<String>,
        isDark: isDark == dimmutable ? _value.isDark : isDark as bool,
        changeTheme: changeTheme == dimmutable
            ? _value.changeTheme
            : changeTheme as AsyncActionField));
  }
}

abstract class _$SampleCopyWith<O> implements $SampleCopyWith<O> {
  factory _$SampleCopyWith(Sample value, O Function(Sample) then) =
      __$SampleCopyWithImpl<O>;
  O call(
      {String name,
      int age,
      StreamField<int, Object> intStream,
      List<String> list,
      bool isDark,
      AsyncActionField changeTheme});
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
      Object? intStream = dimmutable,
      Object? list = dimmutable,
      Object? isDark = dimmutable,
      Object? changeTheme = dimmutable}) {
    return _then(Sample(
        name: name == dimmutable ? _value.name : name as String,
        age: age == dimmutable ? _value.age : age as int,
        intStream: intStream == dimmutable
            ? _value.intStream
            : intStream as StreamField<int, Object>,
        list: list == dimmutable ? _value.list : list as List<String>,
        isDark: isDark == dimmutable ? _value.isDark : isDark as bool,
        changeTheme: changeTheme == dimmutable
            ? _value.changeTheme
            : changeTheme as AsyncActionField));
  }
}

const _Sample_FullPath = "/dstore/test/store/pstates/sample/Sample";

class SampleChangeNameResult implements ToMap {
  final String? name;

  const SampleChangeNameResult({this.name});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (name != null) {
      map["name"] = name;
    }

    return map;
  }
}

class SampleChangeAgeResult implements ToMap {
  final int? age;

  const SampleChangeAgeResult({this.age});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (age != null) {
      map["age"] = age;
    }

    return map;
  }
}

class SampleAddToListResult implements ToMap {
  final List<String>? list;

  const SampleAddToListResult({this.list});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (list != null) {
      map["list"] = list;
    }

    return map;
  }
}

class SampleChangeThemeResult implements ToMap {
  final int? age;
  final bool? isDark;

  const SampleChangeThemeResult({this.age, this.isDark});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (age != null) {
      map["age"] = age;
    }

    if (isDark != null) {
      map["isDark"] = isDark;
    }

    return map;
  }
}

class SampleTestResult implements ToMap {
  final int? age;

  const SampleTestResult({this.age});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (age != null) {
      map["age"] = age;
    }

    return map;
  }
}

abstract class SampleActions {
  static Action<SampleChangeNameResult> changeName(
      {required String newName,
      SampleChangeNameResult? mock,
      bool silent = false}) {
    return Action<SampleChangeNameResult>(
        name: "changeName",
        silent: silent,
        type: _Sample_FullPath,
        payload: <String, dynamic>{"newName": newName},
        mock: mock,
        isAsync: false);
  }

  static Action<SampleChangeAgeResult> changeAge(
      {required int newAge, SampleChangeAgeResult? mock, bool silent = false}) {
    return Action<SampleChangeAgeResult>(
        name: "changeAge",
        silent: silent,
        type: _Sample_FullPath,
        payload: <String, dynamic>{"newAge": newAge},
        mock: mock,
        isAsync: false);
  }

  static Action<SampleAddToListResult> addToList(
      {required String item,
      SampleAddToListResult? mock,
      bool silent = false}) {
    return Action<SampleAddToListResult>(
        name: "addToList",
        silent: silent,
        type: _Sample_FullPath,
        payload: <String, dynamic>{"item": item},
        mock: mock,
        isAsync: false);
  }

  static Action<SampleChangeThemeResult> changeTheme(
      {required bool value,
      Duration? debounce,
      SampleChangeThemeResult? mock,
      bool silent = false}) {
    return Action<SampleChangeThemeResult>(
        name: "changeTheme",
        silent: silent,
        type: _Sample_FullPath,
        payload: <String, dynamic>{"value": value},
        mock: mock,
        isAsync: true,
        debounce: debounce);
  }

  static Action<SampleTestResult> test(
      {required int age2, SampleTestResult? mock, bool silent = false}) {
    return Action<SampleTestResult>(
        name: "test",
        silent: silent,
        type: _Sample_FullPath,
        payload: <String, dynamic>{"age2": age2},
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

    case "test":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
        final age2 = _DstoreActionPayload["age2"] as int;

        var _DStore_age = _DStoreState.age;
        _DStore_age = age2;
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
    case "changeTheme":
      {
        final _DstoreActionPayload = _DstoreAction.payload!;
        final value = _DstoreActionPayload["value"] as bool;

        var _DStore_age = _DStoreState.age;
        var _DStore_isDark = _DStoreState.isDark;
        _DStore_age = 2;
        final s1 = _DStore_age;
        await 5.seconds.delay;
        _DStore_isDark = value;
        return _DStoreState.copyWith(age: _DStore_age, isDark: _DStore_isDark);
      }

    default:
      {
        return _DStoreState;
      }
  }
}

Sample Sample_DS() => Sample(
    name: "hello",
    age: 0,
    intStream: StreamField(),
    list: [],
    isDark: false,
    changeTheme: AsyncActionField());

final SampleMeta = PStateMeta<Sample>(
    type: _Sample_FullPath,
    reducer: Sample_SyncReducer,
    aReducer: Sample_AsyncReducer,
    ds: Sample_DS);
