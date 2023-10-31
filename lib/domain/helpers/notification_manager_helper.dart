import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/app/constants/notification_constants.dart';

class NotificationHelper {
  static const AndroidNotificationDetails defaultAndroidSettings =
      AndroidNotificationDetails(
    NotificationConstants.defaultNotificationChannelId,
    NotificationConstants.defaultNotificationChannelName,
    channelDescription:
        NotificationConstants.defaultNotificationChannelDescription,
  );
  static const DarwinNotificationDetails defaultIosSettings =
      DarwinNotificationDetails();
}
