import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';

class SplashScreenPage extends StatelessWidget {
  static const routeName = '/splash_screen_page';

  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              'Restaurant App',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0), // Atur radius sesuai keinginan
                ),
              ),
              backgroundColor: const MaterialStatePropertyAll<Color>(secondaryColor)
            ),
            child: const Icon(
              Icons.navigate_next_rounded,
              color: Colors.white,
              size: 70,
            ),
            onPressed: () {
               Navigator.pushReplacementNamed(context, '/restaurant_list_page');
            },
          ),
        ],
      ),
    );
  }
}