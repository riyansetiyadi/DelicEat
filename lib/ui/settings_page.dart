import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';
import 'package:restaurant_app_submission_dicoding/provider/preferences_provider.dart';
import 'package:restaurant_app_submission_dicoding/provider/scheduling_provider.dart';
import 'package:restaurant_app_submission_dicoding/widgets/coming_soon_feature_dialog_widget.dart';
import 'package:restaurant_app_submission_dicoding/widgets/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
        automaticallyImplyLeading: false,
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch.adaptive(
                value: provider.isDarkTheme,
                onChanged: (value) {
                  provider.enableDarkTheme(value);
                },
              ),
            ),
          ),
          Material(
            child: ListTile(
              title: const Text('Recomendation Restaurant Notification'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    activeColor: primaryColor,
                    activeTrackColor: secondaryColor,
                    value: provider.isDailyRestaurantRecomendationActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        comingSoonFeatureDialogWidget(context);
                      } else {
                        provider.enableDailyRestaurantRecomendation(value);
                        scheduled.scheduledRestaurantRecomendation(value);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
