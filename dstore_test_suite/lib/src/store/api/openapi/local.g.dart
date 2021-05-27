// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorObject _$ErrorObjectFromJson(Map<String, dynamic> json) => ErrorObject(
      code: json['code'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ErrorObjectToJson(ErrorObject instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
