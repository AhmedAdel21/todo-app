import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/data/plugins/notification_plugin.dart';
import 'package:todo_app/domain/managers/notification_plugin_manager.dart';
import 'package:todo_app/domain/model/models.dart';

class NotificationPluginManagerImpl implements NotificationPluginManager {
  @override
  Future<void> init(void Function(String?) onNotificationClick) async =>
      await NotificationPlugin().initNotificationPlugin(onNotificationClick);

  @override
  Future<void> cancelAllNotification() async =>
      await NotificationPlugin().cancelAllNotification();

  @override
  Future<void> cancelNotificationById(int id) async =>
      await NotificationPlugin().cancelNotificationById(id);

  @override
  Future<void> showNotification({
    required NotificationContent notificationContent,
    required AndroidNotificationDetails androidSettings,
    required DarwinNotificationDetails iosSettings,
  }) async =>
      await NotificationPlugin().showNotification(
        notificationContent: notificationContent,
        androidSettings: androidSettings,
        iosSettings: iosSettings,
      );
}
