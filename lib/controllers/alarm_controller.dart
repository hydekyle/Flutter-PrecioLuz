import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmManager {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    tz.initializeTimeZones();

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  setAlarm(String title, String message, DateTime scheludedTime) {
    if (scheludedTime.isAfter(DateTime.now())) {
      _flutterLocalNotificationsPlugin.zonedSchedule(
          10001,
          title,
          message,
          tz.TZDateTime.from(scheludedTime, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "leonsepia_alarmas",
              "alarmas",
            ),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }
}
