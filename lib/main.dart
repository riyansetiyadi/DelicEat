import 'package:restaurant_app_submission_dicoding/data/api/api_service.dart';
import 'package:restaurant_app_submission_dicoding/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/list_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/review_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/ui/restaurant_detail_page.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/ui/restaurant_list_page.dart';
import 'package:restaurant_app_submission_dicoding/ui/restaurant_search_page.dart';
import 'package:restaurant_app_submission_dicoding/ui/splash_screen_page.dart';
import 'package:provider/provider.dart';

void main() {
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
        )
      ],
      child: MaterialApp(
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
          RestaurantDetailPage.routeName: (context) =>
              ChangeNotifierProvider<DetailRestaurantProvider>(
                create: (_) => DetailRestaurantProvider(
                    apiService: ApiService(),
                    idRestaurant:
                        ModalRoute.of(context)?.settings.arguments as String),
                child: const RestaurantDetailPage(),
              ),
          RestaurantSearchPage.routeName: (context) =>
              const RestaurantSearchPage(),
        },
      ),
    );
  }
}
