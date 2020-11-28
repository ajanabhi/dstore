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
