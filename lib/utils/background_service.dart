import 'dart:ui';
import 'dart:isolate';

import 'package:deliceat/data/api/api_service.dart';
import 'package:deliceat/data/model/restaurant.dart';
import 'package:deliceat/main.dart';
import 'package:deliceat/utils/notification_helper.dart';
import 'package:deliceat/utils/random_item_from_list_function.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  @pragma("vm:entry-point")
  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    RestaurantList listRestaurants = await ApiService().getAllRestaurant();
    Restaurant restaurant = getRandomItemFromList(listRestaurants.restaurant);
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
