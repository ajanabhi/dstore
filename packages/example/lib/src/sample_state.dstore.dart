// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'sample_state.dart';

// **************************************************************************
// AppStateGenerator
// **************************************************************************

mixin _$AppState {
  PStateModel get sample;
  PStateModel get s2;
  AppState copyWithMap(Map<String, dynamic> map) => AppState()
    ..sample = map["sample"] ?? this.sample
    ..s2 = map["s2"] ?? this.s2;
  Map<String, PStateModel> toMap() => {"sample": this.sample, "s2": this.s2};
  static Map<String, PStateMeta> createMeta(
      {required PStateMeta sample, required PStateMeta s2}) {
    return {"sample": sample, "s2": s2};
  }
}
