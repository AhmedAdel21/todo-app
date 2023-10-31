// ignore: must_be_immutable
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';

// ignore: must_be_immutable
class AddTodoTaskObject extends Equatable {
  String? id;
  String? icon;
  String? name;
  String? description;
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  bool isDone;
  AddTodoTaskObject([
    this.id,
    this.icon,
    this.name,
    this.description,
    this.dateTime,
    this.timeOfDay,
    this.isDone = false,
  ]);

  @override
  List<Object?> get props => [
        id,
        icon,
        name,
        description,
        dateTime,
        timeOfDay,
        isDone,
      ];
}

// ignore: must_be_immutable
class TodoTask extends Equatable {
  final String id;
  final TodoTaskIcon icon;
  final String name;
  final String description;
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  bool isDone;
  TodoTask({
    required this.id,
    required this.icon,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.timeOfDay,
    required this.isDone,
  });
  String get getTitle => name;
  String get getDate => DateFormat('dd MMM').format(dateTime.toLocal());
  String get getTime =>
      "${timeOfDay.hour.toString().padLeft(2, "0")}:${timeOfDay.minute.toString().padLeft(2, "0")}";
  @override
  List<Object?> get props => [
        id,
        icon,
        name,
        description,
        dateTime,
        timeOfDay,
        isDone,
      ];

  TodoTask copyWith({
    String? id,
    TodoTaskIcon? icon,
    String? name,
    String? description,
    DateTime? dateTime,
    TimeOfDay? timeOfDay,
    bool? isDone,
  }) =>
      TodoTask(
        id: id ?? this.id,
        icon: icon ?? this.icon,
        name: name ?? this.name,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        timeOfDay: timeOfDay ?? this.timeOfDay,
        isDone: isDone ?? this.isDone,
      );
}

enum TodoTaskCardMode { normal, selectable }

enum TodoTaskCardViewMode { list, calender }

enum HomePageViewMode { list, calender }

enum DataState { loading, data, empty, error }
