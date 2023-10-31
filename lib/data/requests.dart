import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoTaskRequestObject extends Equatable {
  String icon;
  String name;
  String description;
  DateTime dateTime;
  TimeOfDay timeOfDay;
  bool isDone;
  TodoTaskRequestObject({
    required this.icon,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.timeOfDay,
    this.isDone = false,
  });
  @override
  String toString() =>
      "TodoTaskRequestObject(icon: $icon, name: $name, description: $description, dateTime: $dateTime, timeOfDay: $timeOfDay, isDone: $isDone)";
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

class LoginRequest {
  String username;
  String password;
  LoginRequest(this.username, this.password);
}
