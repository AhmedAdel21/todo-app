import 'package:flutter/material.dart';
import 'package:todo_app/app/constants/global_constants.dart';
import 'package:todo_app/data/data_source/local_data_source/permanent_data_source/hive_database.dart/hive_classes.dart';
import 'package:todo_app/data/response/responses.dart';
import 'package:todo_app/domain/model/models.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import "package:todo_app/app/extensions.dart";

extension ToTodoTaskExtension on TodoTaskHive {
  TodoTask get toDomain => TodoTask(
      id: id,
      icon: TodoTaskIcon.fromImageString(icon),
      name: name,
      description: description,
      dateTime: dateTime,
      timeOfDay: TimeOfDay(hour: hour, minute: minute),
      isDone: isDone);
}

extension AuthenticationMapper on AuthenticationResponse? {
  Authentication get toDomain => Authentication(
        this?.userId.orMinusOne ?? Constants.minusOne,
        this?.userName.orEmpty ?? Constants.empty,
        this?.password.orEmpty ?? Constants.empty,
      );
}
