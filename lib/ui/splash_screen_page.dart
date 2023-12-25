import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';
import 'package:restaurant_app_submission_dicoding/ui/home_page.dart';
import 'package:restaurant_app_submission_dicoding/widgets/platform_widget.dart';

class SplashScreenPage extends StatelessWidget {
  static const routeName = '/splash_screen_page';

  const SplashScreenPage({super.key});

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildSplashScreen(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildSplashScreen(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildSplashScreen(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text('Welcome',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          SizedBox(
            width: double.infinity,
            child: Text('Restaurant App',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(secondaryColor)),
            child: Icon(
              defaultTargetPlatform == TargetPlatform.iOS
                  ? CupertinoIcons.right_chevron
                  : Icons.navigate_next_rounded,
              color: Colors.white,
              size: 70,
            ),
            onPressed: () {
              defaultTargetPlatform == TargetPlatform.iOS
                  ? Navigator.of(context).pushReplacement(HomePage.route())
                  : Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
