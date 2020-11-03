// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()..name = json['name'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
    };

Sample _$SampleFromJson(Map<String, dynamic> json) {
  return Sample(
    count: json['count'] as int,
    s: json['s'] as int,
    name: json['name'] == null
        ? null
        : User.fromJson(json['name'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SampleToJson(Sample instance) => <String, dynamic>{
      'count': instance.count,
      's': instance.s,
      'name': instance.name,
    };
