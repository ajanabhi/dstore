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
