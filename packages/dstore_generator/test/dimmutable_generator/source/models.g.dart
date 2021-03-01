// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelloS _$HelloSFromJson(Map<String, dynamic> json) {
  return HelloS(
    json['name'] as String,
  );
}

Map<String, dynamic> _$HelloSToJson(HelloS instance) => <String, dynamic>{
      'name': instance.name,
    };

Hello3 _$Hello3FromJson(Map<String, dynamic> json) {
  return Hello3(
    (json['hellos'] as List<dynamic>)
        .map((e) => Hello.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['hellos2'] as List<dynamic>)
        .map((e) => HelloS.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$Hello3ToJson(Hello3 instance) => <String, dynamic>{
      'hellos': instance.hellos.map((e) => e.toJson()).toList(),
      'hellos2': instance.hellos2.map((e) => e.toJson()).toList(),
    };

_Hello _$_HelloFromJson(Map<String, dynamic> json) {
  return _Hello(
    name2: json['name2'] as String,
  );
}

Map<String, dynamic> _$_HelloToJson(_Hello instance) => <String, dynamic>{
      'name2': instance.name2,
    };

_Hello2 _$_Hello2FromJson(Map<String, dynamic> json) {
  return _Hello2(
    hellos: (json['hellos'] as List<dynamic>)
        .map((e) => Hello.fromJson(e as Map<String, dynamic>))
        .toList(),
    h: Hello.fromJson(json['h'] as Map<String, dynamic>),
    age: json['age'] as int,
  );
}

Map<String, dynamic> _$_Hello2ToJson(_Hello2 instance) => <String, dynamic>{
      'hellos': instance.hellos.map((e) => e.toJson()).toList(),
      'h': instance.h.toJson(),
      'age': instance.age,
    };
