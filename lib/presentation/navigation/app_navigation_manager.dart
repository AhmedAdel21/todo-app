import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/di.dart';
import 'package:todo_app/domain/managers/notification_manager.dart';
import 'package:todo_app/presentation/navigation/app_router.dart';

abstract class AppNavigationManager {
  void init();
  void setCurrentRoutePath(String newPath);
  void goToHomePage();
  bool get isAppActive;
  String get getCurrentRoutePath;
}

class AppNavigationManagerImpl extends ChangeNotifier
    implements AppNavigationManager {
  final GlobalKey<NavigatorState> _navigatorKey = navigatorKey;
  String _currentRoutePath = "";

  @override
  bool get isAppActive => _navigatorKey.currentContext != null;

  @override
  String get getCurrentRoutePath => _currentRoutePath;
  @override
  void setCurrentRoutePath(String newPath) => _currentRoutePath = newPath;

  @override
  void goToHomePage() {
    if (_navigatorKey.currentContext != null) {
      Navigator.of(_navigatorKey.currentContext!)
          .popUntil((route) => route.isFirst);
      _navigatorKey.currentContext!.pushReplacementNamed(RoutesName.home);
    }
  }

  @override
  void init() {
    DI
        .getItInstance<NotificationManager>()
        .onNotificationClicked
        .listen((event) {});
  }
}
