import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';
import 'package:restaurant_app_submission_dicoding/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRestaurantNotificationPreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyRestaurantRecomendationActive = false;
  bool get isDailyRestaurantRecomendationActive => _isDailyRestaurantRecomendationActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyRestaurantNotificationPreferences() async {
    _isDailyRestaurantRecomendationActive = await preferencesHelper.isDailyRestaurantRecomendationActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyRestaurantRecomendation(bool value) {
    preferencesHelper.setDailyRestaurantRecomendation(value);
    _getDailyRestaurantNotificationPreferences();
  }
}
