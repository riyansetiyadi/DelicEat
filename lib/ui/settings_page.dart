import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deliceat/common/styles.dart';
import 'package:deliceat/provider/preferences_provider.dart';
import 'package:deliceat/provider/scheduling_provider.dart';
import 'package:deliceat/widgets/coming_soon_feature_dialog_widget.dart';
import 'package:deliceat/widgets/platform_widget.dart';

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
    return Consumer<PreferencesProvider>(
        builder: (context, preferences, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch.adaptive(
                activeColor:
                    preferences.isDarkTheme ? darkPrimaryColor : primaryColor,
                activeTrackColor: preferences.isDarkTheme
                    ? darkSecondaryColor
                    : secondaryColor,
                value: preferences.isDarkTheme,
                onChanged: (value) {
                  preferences.enableDarkTheme(value);
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
                    activeColor: preferences.isDarkTheme
                        ? darkPrimaryColor
                        : primaryColor,
                    activeTrackColor: preferences.isDarkTheme
                        ? darkSecondaryColor
                        : secondaryColor,
                    value: preferences.isDailyRestaurantRecomendationActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        comingSoonFeatureDialogWidget(context);
                      } else {
                        preferences.enableDailyRestaurantRecomendation(value);
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
