// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample.dart';

// **************************************************************************
// ReducerGenerator
// **************************************************************************

// class Name : _SampleReducer

@immutable
@JsonSerializable()
class Sample {
  final int count;
  final int s;
  final User name;

  Sample({@required this.count, @required this.s, @required this.name});

  Sample copyWith({int count, int s, User name}) => Sample(
      count: count ?? this.count, s: s ?? this.s, name: name ?? this.name);

  Sample copyWithMap(Map<String, dynamic> map) => Sample(
      count: map["count"] ?? this.count,
      s: map["s"] ?? this.s,
      name: map["name"] ?? this.name);
}

final SampleReducerGroup = ReducerGroup(
    group: "Sample",
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
    ds: Sample(count: 0, s: 0, name: User()));
