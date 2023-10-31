import 'package:shared_preferences/shared_preferences.dart';

class AppCacheKeys {
  static const isUserLoggedIn = "isUserLoggedIn";
}

abstract class AppSharedPrefs {
  Future<void> setIsUserLoggedIn(bool value);
  bool getIsUserLoggedIn();
}

class AppSharedPrefsImpl implements AppSharedPrefs {
  final SharedPreferences _sharedPreferences;
  AppSharedPrefsImpl(this._sharedPreferences);

  @override
  Future<void> setIsUserLoggedIn(bool value) async =>
      await _sharedPreferences.setBool(AppCacheKeys.isUserLoggedIn, value);
      
  @override
  bool getIsUserLoggedIn() =>
      _sharedPreferences.getBool(AppCacheKeys.isUserLoggedIn) ?? false;
}
