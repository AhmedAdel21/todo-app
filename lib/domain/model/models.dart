import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: must_be_immutable
class TodoTask extends Equatable {
  String id;
  String icon;
  String name;
  String description;
  DateTime dateTime;
  TimeOfDay timeOfDay;
  bool isDone;

  TodoTask({
    required this.id,
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

class NotificationContent {
  int id;
  String? title;
  String? body;
  String? payload;
  NotificationContent(
    this.id, {
    this.title,
    this.body,
    this.payload,
  });
}

class NotificationSettings {
  AndroidNotificationDetails androidSettings;
  DarwinNotificationDetails iosSettings;
  NotificationSettings(this.androidSettings, this.iosSettings);
}
