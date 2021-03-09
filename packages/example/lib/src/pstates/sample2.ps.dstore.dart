// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample2.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

@immutable
class Sample2 implements PStateModel {
  final int count;

  final String name;

  final String? comment;

  _$Sample2CopyWith<Sample2> get copyWith =>
      __$Sample2CopyWithImpl<Sample2>(this, IdentityFn);

  const Sample2({this.count = 0, this.name = "hello2", this.comment = null});

  @override
  Sample2 copyWithMap(Map<String, dynamic> map) => Sample2(
      count: map["count"] ?? this.count,
      name: map["name"] ?? this.name,
      comment: map["comment"] ?? this.comment);

  Map<String, dynamic> toMap() =>
      {"count": this.count, "name": this.name, "comment": this.comment};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Sample2 &&
        o.count == count &&
        o.name == name &&
        o.comment == comment;
  }

  @override
  int get hashCode => count.hashCode ^ name.hashCode ^ comment.hashCode;

  @override
  String toString() =>
      "Sample2(count: ${this.count}, name: ${this.name}, comment: ${this.comment})";
}

abstract class $Sample2CopyWith<O> {
  factory $Sample2CopyWith(Sample2 value, O Function(Sample2) then) =
      _$Sample2CopyWithImpl<O>;
  O call({int count, String name, String? comment});
}

class _$Sample2CopyWithImpl<O> implements $Sample2CopyWith<O> {
  final Sample2 _value;
  final O Function(Sample2) _then;
  _$Sample2CopyWithImpl(this._value, this._then);

  @override
  O call(
      {Object? count = dimmutable,
      Object? name = dimmutable,
      Object? comment = dimmutable}) {
    return _then(_value.copyWith(
        count: count == dimmutable ? _value.count : count as int,
        name: name == dimmutable ? _value.name : name as String,
        comment: comment == dimmutable ? _value.comment : comment as String?));
  }
}

abstract class _$Sample2CopyWith<O> implements $Sample2CopyWith<O> {
  factory _$Sample2CopyWith(Sample2 value, O Function(Sample2) then) =
      __$Sample2CopyWithImpl<O>;
  O call({int count, String name, String? comment});
}

class __$Sample2CopyWithImpl<O> extends _$Sample2CopyWithImpl<O>
    implements _$Sample2CopyWith<O> {
  __$Sample2CopyWithImpl(Sample2 _value, O Function(Sample2) _then)
      : super(_value, (v) => _then(v));

  @override
  Sample2 get _value => super._value;

  @override
  O call(
      {Object? count = dimmutable,
      Object? name = dimmutable,
      Object? comment = dimmutable}) {
    return _then(Sample2(
        count: count == dimmutable ? _value.count : count as int,
        name: name == dimmutable ? _value.name : name as String,
        comment: comment == dimmutable ? _value.comment : comment as String?));
  }
}

abstract class Sample2Actions {
  static Action increment() {
    return Action(name: "increment", type: Sample2, isAsync: false);
  }
}

dynamic Sample2_SyncReducer(dynamic _DStoreState, Action _DstoreAction) {
  _DStoreState = _DStoreState as Sample2;
  final name = _DstoreAction.name;
  switch (name) {
    case "increment":
      {
        var _DStore_count = _DStoreState.count;
        var _DStore_name = _DStoreState.name;
        _DStore_count += 1;
        print("hello");
        try {
          _DStore_name = "hello2";
        } on Exception catch (s, sp2) {
          print(s);
        } catch (e2) {} finally {
          print("final");
        }

        for (var i = 0; i < 10; i++) {
          _DStore_count = 4;
        }

        return _DStoreState.copyWith(count: _DStore_count, name: _DStore_name);
      }

    default:
      {
        return _DStoreState;
      }
  }
}

Sample2 Sample2_DS() => Sample2(count: 0, name: "hello2", comment: null);

const Sample2Meta = PStateMeta<Sample2>(
    type: Sample2,
    reducer: Sample2_SyncReducer,
    aReducer: null,
    ds: Sample2_DS);
