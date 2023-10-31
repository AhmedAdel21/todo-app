// ignore: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoTaskLocalSourceInput extends Equatable {
  String icon;
  String name;
  String description;
  DateTime dateTime;
  TimeOfDay timeOfDay;
  bool isDone;
  TodoTaskLocalSourceInput({
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
