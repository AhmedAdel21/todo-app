import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/domain/model/models.dart';

abstract class NotificationPluginManager {
  Future<void> init(void Function(String?) onNotificationClick);
  Future<void> cancelAllNotification();
  Future<void> cancelNotificationById(int id);
  Future<void> showNotification(
      {required NotificationContent notificationContent,
      required AndroidNotificationDetails androidSettings,
      required DarwinNotificationDetails iosSettings});
}
