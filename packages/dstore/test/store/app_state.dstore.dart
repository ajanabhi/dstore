// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'app_state.dart';

// **************************************************************************
// AppStateGenerator
// **************************************************************************

mixin _$AppState {
  Sample get sample;
  Sample2 get sample2;
  AppState copyWithMap(Map<String, dynamic> map) => AppState()
    ..sample = map.containsKey('sample') ? map['sample'] as Sample : this.sample
    ..sample2 =
        map.containsKey('sample2') ? map['sample2'] as Sample2 : this.sample2;
  Map<String, PStateModel> toMap() =>
      <String, PStateModel>{"sample": this.sample, "sample2": this.sample2};
}
Map<String, PStateMeta> createAppStateMeta() {
  return <String, PStateMeta>{"sample": SampleMeta, "sample2": Sample2Meta};
}
