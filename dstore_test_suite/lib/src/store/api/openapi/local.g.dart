// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

helloJsonResponse _$helloJsonResponseFromJson(Map<String, dynamic> json) =>
    helloJsonResponse(
      name: json['name'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$helloJsonResponseToJson(helloJsonResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
    };

PaginationPathParams _$PaginationPathParamsFromJson(
        Map<String, dynamic> json) =>
    PaginationPathParams(
      page: json['page'] as int,
    );

Map<String, dynamic> _$PaginationPathParamsToJson(
        PaginationPathParams instance) =>
    <String, dynamic>{
      'page': instance.page,
    };

PaginationResponse _$PaginationResponseFromJson(Map<String, dynamic> json) =>
    PaginationResponse(
      list: (json['list'] as List<dynamic>).map((e) => e as String).toList(),
      nextPage: json['nextPage'] as int?,
    );

Map<String, dynamic> _$PaginationResponseToJson(PaginationResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
      'nextPage': instance.nextPage,
    };
