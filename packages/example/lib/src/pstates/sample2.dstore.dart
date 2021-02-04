// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample2.dart';

// **************************************************************************
// PStateGenerator
// **************************************************************************

// class Name : _Sample2

@immutable
class Sample2 implements PStateModel {
  final int count;

  final String name;

  final List<String> s;

  const Sample2({required this.count, required this.name, required this.s});

  Sample2 copyWith({int? count, String? name, List<String>? s}) => Sample2(
      count: count ?? this.count, name: name ?? this.name, s: s ?? this.s);

  @override
  Sample2 copyWithMap(Map<String, dynamic> map) => Sample2(
      count: map["count"] ?? this.count,
      name: map["name"] ?? this.name,
      s: map["s"] ?? this.s);

  Map<String, dynamic> toMap() =>
      {"count": this.count, "name": this.name, "s": this.s};

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Sample2 && o.count == count && o.name == name && o.s == s;
  }

  @override
  int get hashCode => count.hashCode ^ name.hashCode ^ s.hashCode;

  @override
  String toString() =>
      "Sample2(count: ${this.count}, name: ${this.name}, s: ${this.s})";
}

abstract class Sample2Actions {
  static Action increment() {
    return Action(name: "increment", group: 33202611, isAsync: false);
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

        return _DStoreState.copyWith(count: _DStore_count, name: _DStore_name);
      }

    default:
      {
        return _DStoreState;
      }
  }
}

Future<dynamic> Sample2_AsyncReducer(
    dynamic _DStoreState, Action _DstoreAction) async {
  _DStoreState = _DStoreState as Sample2;
  final name = _DstoreAction.name;
  switch (name) {
    default:
      {
        return _DStoreState;
      }
  }
}

Sample2 Sample2_DS() => Sample2(count: 0, name: "hello", s: []);

const Sample2Meta = PStateMeta<Sample2>(
    group: 33202611,
    reducer: Sample2_SyncReducer,
    aReducer: Sample2_AsyncReducer,
    ds: Sample2_DS);
