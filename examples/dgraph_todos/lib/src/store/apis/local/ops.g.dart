// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ops.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hello_todoData _$Hello_todoDataFromJson(Map<String, dynamic> json) {
  return Hello_todoData(
    todo: json['todo'] == null
        ? null
        : Hello_todoData_todo.fromJson(json['todo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$Hello_todoDataToJson(Hello_todoData instance) =>
    <String, dynamic>{
      'todo': instance.todo,
    };

Hello_todoData_todo _$Hello_todoData_todoFromJson(Map<String, dynamic> json) {
  return Hello_todoData_todo(
    text: json['text'] as String?,
  );
}

Map<String, dynamic> _$Hello_todoData_todoToJson(
        Hello_todoData_todo instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

Hello_utData _$Hello_utDataFromJson(Map<String, dynamic> json) {
  return Hello_utData(
    hellou:
        Hello_utData_hellou.fromJson(json['hellou'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$Hello_utDataToJson(Hello_utData instance) =>
    <String, dynamic>{
      'hellou': Hello_utData_hellou.toJson(instance.hellou),
    };

Hello_utData_hellou_Hello1 _$Hello_utData_hellou_Hello1FromJson(
    Map<String, dynamic> json) {
  return Hello_utData_hellou_Hello1(
    one: json['one'] as String,
    d$___typeName: json['__typename'] as String,
  );
}

Map<String, dynamic> _$Hello_utData_hellou_Hello1ToJson(
        Hello_utData_hellou_Hello1 instance) =>
    <String, dynamic>{
      'one': instance.one,
      '__typename': instance.d$___typeName,
    };
