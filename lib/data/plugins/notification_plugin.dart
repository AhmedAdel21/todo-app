import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:todo_app/domain/model/models.dart';

class NotificationPlugin {
  static final NotificationPlugin _notificationPlugin = NotificationPlugin._();
  factory NotificationPlugin() => _notificationPlugin;

  static late FlutterLocalNotificationsPlugin _plugin;
  late InitializationSettings _initializationSettings;

  NotificationPlugin._() {
    _init();
  }
  Future<void> _init() async {
    _plugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      await _requestIOSPermission();
    }
    _initializePlatformSpecifies();
  }

  void _initializePlatformSpecifies() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings("logo");
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      requestCriticalPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );
    _initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  _requestIOSPermission() {
    _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> initNotificationPlugin(
      void Function(String? payload) onNotificationClick) async {
    await _plugin.initialize(
      _initializationSettings,
      // onDidReceiveNotificationResponse: (payload) async {
      //   // onNotificationClick(payload.payload);
      // },
      // onDidReceiveBackgroundNotificationResponse: (payload) async {
      //   // onNotificationClick(payload.payload);
      // },
    );
    await _plugin.getNotificationAppLaunchDetails();
  }

  Future<void> showNotification({
    required NotificationContent notificationContent,
    required AndroidNotificationDetails androidSettings,
    required DarwinNotificationDetails iosSettings,
  }) async {
    var platformChannelSpecifies =
        NotificationDetails(android: androidSettings, iOS: iosSettings);

    await _plugin.show(
      notificationContent.id,
      notificationContent.title,
      notificationContent.body,
      platformChannelSpecifies,
      payload: notificationContent.payload,
    );
  }

  Future<void> cancelNotificationById(int id) async => await _plugin.cancel(id);

  Future<void> cancelAllNotification() async => await _plugin.cancelAll();
}
