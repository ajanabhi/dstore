// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample.dart';

// **************************************************************************
// ReducerGenerator
// **************************************************************************

// class Name : _SampleReducer

@immutable
class Sample {
  final int count;
  final int s;

  Sample({@required this.count, @required this.s});

  Sample copyWith({int count, int s}) =>
      Sample(count: count ?? this.count, s: s ?? this.s);

  Sample copyWithMap(Map<String, dynamic> map) =>
      Sample(count: map["count"] ?? this.count, s: map["s"] ?? this.s);
}

// Methods : increment : increment() {var count2 = 4; count++; count = 3; count2 = 5; this.count = 6; print(count2);};
