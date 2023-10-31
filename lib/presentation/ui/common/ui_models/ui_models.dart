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



enum TodoTaskCardMode { normal, selectable }

enum TodoTaskCardViewMode { list, calender }

enum HomePageViewMode { list, calender }

enum DataState { loading, data, empty, error }

class UserLoginData {
  String? userName;
  String? password;
  UserLoginData([this.userName, this.password]);
}
