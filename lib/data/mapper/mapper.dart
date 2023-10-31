import 'package:flutter/material.dart';
import 'package:todo_app/data/local_data_source/permanent_data_source/hive_database.dart/hive_classes.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

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
