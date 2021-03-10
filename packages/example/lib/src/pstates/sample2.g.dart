// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sample2 _$Sample2FromJson(Map<String, dynamic> json) {
  return Sample2(
    count: json['count'] as int,
    name: json['name'] as String,
    comment: json['comment'] as String?,
  );
}

Map<String, dynamic> _$Sample2ToJson(Sample2 instance) => <String, dynamic>{
      'count': instance.count,
      'name': instance.name,
      'comment': instance.comment,
    };

_TU _$_TUFromJson(Map<String, dynamic> json) {
  return _TU(
    s: json['s'] as String,
    h2: json['h2'] as String? ?? '2',
    h: json['h'] as String? ?? 'hello',
  );
}

Map<String, dynamic> _$_TUToJson(_TU instance) => <String, dynamic>{
      's': instance.s,
      'h2': instance.h2,
      'h': instance.h,
    };
