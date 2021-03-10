// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

One _$OneFromJson(Map<String, dynamic> json) {
  return One(
    json['name'] as String,
  );
}

Map<String, dynamic> _$OneToJson(One instance) => <String, dynamic>{
      'name': instance.name,
    };

JsonEx _$JsonExFromJson(Map<String, dynamic> json) {
  return JsonEx(
    json['name'] as String,
  );
}

Map<String, dynamic> _$JsonExToJson(JsonEx instance) => <String, dynamic>{
      'name': instance.name,
    };

Sample _$SampleFromJson(Map<String, dynamic> json) {
  return Sample(
    count: json['count'] as int,
    fint: AsyncActionField.fromJson(json['fint'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SampleToJson(Sample instance) => <String, dynamic>{
      'count': instance.count,
      'fint': instance.fint,
    };

_User _$_UserFromJson(Map<String, dynamic> json) {
  return _User(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$_UserToJson(_User instance) => <String, dynamic>{
      'name': instance.name,
    };
