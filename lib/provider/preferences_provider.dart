import 'package:flutter/material.dart';
import 'package:deliceat/common/styles.dart';
import 'package:deliceat/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRestaurantNotificationPreferences();
    _getFirstLaunchAppPreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  bool _isDailyRestaurantRecomendationActive = false;
  bool get isDailyRestaurantRecomendationActive => _isDailyRestaurantRecomendationActive;

  void _getDailyRestaurantNotificationPreferences() async {
    _isDailyRestaurantRecomendationActive = await preferencesHelper.isDailyRestaurantRecomendationActive;
    notifyListeners();
  }

  void enableDailyRestaurantRecomendation(bool value) {
    preferencesHelper.setDailyRestaurantRecomendation(value);
    _getDailyRestaurantNotificationPreferences();
  }

  bool _isFirstLaunchApp = true;
  bool get isFirstLaunchApp => _isFirstLaunchApp;

  void _getFirstLaunchAppPreferences() async {
    _isFirstLaunchApp = await preferencesHelper.isFirstLaunchApp;
    notifyListeners();
  }

  void setFirstLaunchAppPreferences(bool value) {
    preferencesHelper.setFirstLaunchApp(value);
    _getFirstLaunchAppPreferences();
  }
}
