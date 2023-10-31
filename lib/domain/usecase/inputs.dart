// ignore: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddTodoTaskUseCaseInput extends Equatable {
  String icon;
  String name;
  String description;
  DateTime dateTime;
  TimeOfDay timeOfDay;
  bool isDone;
  AddTodoTaskUseCaseInput({
    required this.icon,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.timeOfDay,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [
        icon,
        name,
        description,
        dateTime,
        timeOfDay,
        isDone,
      ];
}

class UserLoginDataUseCaseInput {
  String userName;
  String password;
  UserLoginDataUseCaseInput(this.userName, this.password);
}
