// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample_state.dart';

// **************************************************************************
// AppStateGenerator
// **************************************************************************

mixin _$AppState {
  Sample get sample;
  Sample2 get sample2;
  AppState copyWithMap(Map<String, dynamic> map) => AppState()
    ..sample = map["sample"] ?? this.sample
    ..sample2 = map["sample2"] ?? this.sample2;
  Map<String, PStateModel> toMap() =>
      {"sample": this.sample, "sample2": this.sample2};
}
Map<String, PStateMeta> createAppStateMeta(
    {required PStateMeta<Sample> sample,
    required PStateMeta<Sample2> sample2}) {
  return {"sample": sample, "sample2": sample2};
}
