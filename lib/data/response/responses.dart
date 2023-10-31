// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class TodoTaskResponse {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "icon")
  String? icon;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "isDone")
  bool? isDone;

  @JsonKey(name: "dateTime")
  DateTime? dateTime;

  TodoTaskResponse(
    this.id,
    this.icon,
    this.name,
    this.description,
    this.isDone,
    this.dateTime,
  );

  // from json
  factory TodoTaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoTaskResponseFromJson(json);
  // to json

  Map<String, dynamic> toJson() => _$TodoTaskResponseToJson(this);
}

@JsonSerializable()
class TodoTasksResponse {
  @JsonKey(name: "tasks")
  List<TodoTaskResponse>? tasks;

  TodoTasksResponse(this.tasks);

  // from json
  factory TodoTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoTasksResponseFromJson(json);
  // to json

  Map<String, dynamic> toJson() => _$TodoTasksResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "userId")
  int? userId;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "password")
  String? password;
  AuthenticationResponse(this.userId, this.userName, this.password);

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
