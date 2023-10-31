import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/domain/helpers/notification_manager_helper.dart';
import 'package:todo_app/domain/managers/notification_plugin_manager.dart';
import 'package:todo_app/domain/model/models.dart';

abstract class NotificationManager {
  Future<void> init();
  Future<void> cancelAllNotification();
  Future<void> cancelNotificationById(int id);
  Future<void> showNotification(NotificationContent notificationContent);
  Stream<String?> get onNotificationClicked;
}

class NotificationManagerImpl implements NotificationManager {
  final NotificationPluginManager notificationPluginManager;

  NotificationManagerImpl(this.notificationPluginManager);

  StreamController<String?> onNotificationClickedSC =
      StreamController<String?>.broadcast();

  @override
  Future<void> showNotification(
    NotificationContent notificationContent, {
    AndroidNotificationDetails? androidSettings,
    DarwinNotificationDetails? iosSettings,
  }) async {
    notificationPluginManager.showNotification(
      notificationContent: notificationContent,
      androidSettings:
          androidSettings ?? NotificationHelper.defaultAndroidSettings,
      iosSettings: iosSettings ?? NotificationHelper.defaultIosSettings,
    );
  }

  @override
  Future<void> init() async =>
      await notificationPluginManager.init(onNotificationClick);

  @override
  Future<void> cancelAllNotification() async =>
      await notificationPluginManager.cancelAllNotification();

  @override
  Future<void> cancelNotificationById(int id) async =>
      await notificationPluginManager.cancelNotificationById(id);

  @override
  Stream<String?> get onNotificationClicked => onNotificationClickedSC.stream;
}

@pragma('vm:entry-point')
void onNotificationClick(String? payload) {
}
