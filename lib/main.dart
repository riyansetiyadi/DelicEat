import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app_submission_dicoding/common/navigation.dart';
import 'package:restaurant_app_submission_dicoding/data/api/api_service.dart';
import 'package:restaurant_app_submission_dicoding/data/preferences/preferences_helper.dart';
import 'package:restaurant_app_submission_dicoding/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/list_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/preferences_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/review_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/scheduling_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/ui/home_page.dart';
import 'package:restaurant_app_submission_dicoding/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/ui/restaurant_list_page.dart';
import 'package:restaurant_app_submission_dicoding/ui/restaurant_search_page.dart';
import 'package:restaurant_app_submission_dicoding/ui/splash_screen_page.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_dicoding/utils/background_service.dart';
import 'package:restaurant_app_submission_dicoding/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SearchRestaurantProvider>(
            create: (_) => SearchRestaurantProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider<ListRestaurantProvider>(
            create: (_) => ListRestaurantProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider<ReviewRestaurantProvider>(
            create: (_) => ReviewRestaurantProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
        ],
        child:
            Consumer<PreferencesProvider>(builder: (context, provider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'DelicEat',
            theme: provider.themeData,
            initialRoute: SplashScreenPage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              SplashScreenPage.routeName: (context) => const SplashScreenPage(),
              RestaurantListPage.routeName: (context) =>
                  const RestaurantListPage(),
              RestaurantDetailPage.routeName: (context) =>
                  ChangeNotifierProvider<DetailRestaurantProvider>(
                    create: (_) => DetailRestaurantProvider(
                        apiService: ApiService(),
                        idRestaurant: ModalRoute.of(context)?.settings.arguments
                            as String),
                    child: const RestaurantDetailPage(),
                  ),
              RestaurantSearchPage.routeName: (context) =>
                  const RestaurantSearchPage(),
            },
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
          );
        }));
  }
}
