// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

TodoTaskResponse _$TodoTaskResponseFromJson(Map<String, dynamic> json) =>
    TodoTaskResponse(
      json['id'] as String?,
      json['icon'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['isDone'] as bool?,
      json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$TodoTaskResponseToJson(TodoTaskResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.name,
      'description': instance.description,
      'isDone': instance.isDone,
      'dateTime': instance.dateTime?.toIso8601String(),
    };

TodoTasksResponse _$TodoTasksResponseFromJson(Map<String, dynamic> json) =>
    TodoTasksResponse(
      (json['tasks'] as List<dynamic>?)
          ?.map((e) => TodoTaskResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoTasksResponseToJson(TodoTasksResponse instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['userId'] as int?,
      json['userName'] as String?,
      json['password'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'userId': instance.userId,
      'userName': instance.userName,
      'password': instance.password,
    };
