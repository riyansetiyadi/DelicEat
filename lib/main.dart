import 'package:deliceat/data/model/restaurant.dart';
import 'package:deliceat/ui/restaurant_detail_page.dart';
import 'package:deliceat/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:deliceat/ui/restaurant_list_page.dart';
import 'package:deliceat/ui/splash_screen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
      ),
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => const SplashScreenPage(),
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}