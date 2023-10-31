import 'package:shared_preferences/shared_preferences.dart';

class AppCacheKeys {
  static const isUserLoggedIn = "isUserLoggedIn";
  static const userName = "userName";
  static const password = "password";
}

abstract class AppSharedPrefs {
  Future<void> setIsUserLoggedIn(bool value);
  bool getIsUserLoggedIn();

  Future<void> setUserName(String userName);
  String getUserName();

  Future<void> setPassword(String password);
  String getPassword();
}

class AppSharedPrefsImpl implements AppSharedPrefs {
  final SharedPreferences _sharedPreferences;
  AppSharedPrefsImpl(this._sharedPreferences);

  @override
  Future<void> setIsUserLoggedIn(bool value) async =>
      await _sharedPreferences.setBool(AppCacheKeys.isUserLoggedIn, value);

  @override
  Future<void> setPassword(String password) async =>
      await _sharedPreferences.setString(AppCacheKeys.password, password);

  @override
  Future<void> setUserName(String userName) async =>
      await _sharedPreferences.setString(AppCacheKeys.userName, userName);

  @override
  bool getIsUserLoggedIn() =>
      _sharedPreferences.getBool(AppCacheKeys.isUserLoggedIn) ?? false;

  @override
  String getPassword() =>
      _sharedPreferences.getString(AppCacheKeys.password) ?? "";

  @override
  String getUserName() =>
      _sharedPreferences.getString(AppCacheKeys.userName) ?? "";
}
