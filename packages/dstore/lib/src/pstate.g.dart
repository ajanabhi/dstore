// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pstate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AsyncActionField _$_AsyncActionFieldFromJson(Map<String, dynamic> json) {
  return _AsyncActionField(
    loading: json['loading'] as bool? ?? false,
    error: json['error'],
  );
}

Map<String, dynamic> _$_AsyncActionFieldToJson(_AsyncActionField instance) =>
    <String, dynamic>{
      'loading': instance.loading,
      'error': instance.error,
    };
