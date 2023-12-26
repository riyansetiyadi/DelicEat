import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const darkTheme = 'DARK_THEME';
  static const dailyRestaurantNotification = 'DAILY_RESTAURANT';
  static const firstLaunchApp = 'FIRST_LAUNCH_APP';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isDailyRestaurantRecomendationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurantNotification) ?? false;
  }

  void setDailyRestaurantRecomendation(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurantNotification, value);
  }

  Future<bool> get isFirstLaunchApp async {
    final prefs = await sharedPreferences;
    return prefs.getBool(firstLaunchApp) ?? true;
  }

  void setFirstLaunchApp(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(firstLaunchApp, value);
  }
}
