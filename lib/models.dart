import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AppController extends GetxController {
  late final SharedPreferences storage;
  final List<Price> priceList = List<Price>.empty().obs;
  final Api api = Api();
  final AlarmManager alarmManager = AlarmManager();
  final navbarIndex = 0.obs;

  init() async {
    storage = await SharedPreferences.getInstance();
    alarmManager.init();
    loadPriceList();
  }

  loadPriceList() async {
    var response = await api.getPriceList();
    final dataEncoded = jsonEncode(response.body);
    final Map<String, dynamic> jsonData = jsonDecode(dataEncoded);
    priceList.clear();
    jsonData.forEach((key, value) {
      var price = Price.fromJSON(value);
      priceList.add(price);
      print(price.hour);
    });
  }
}

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

class Price {
  final String date, hour, market, units;
  final bool isCheap, isUnderAvg;
  final double price;

  Price(this.date, this.hour, this.market, this.units, this.isCheap,
      this.isUnderAvg, this.price);

  Price.fromJSON(Map<String, dynamic> json)
      : date = json["date"],
        hour = json["hour"],
        market = json["market"],
        units = json["units"],
        isCheap = json["is-cheap"],
        isUnderAvg = json["is-under-avg"],
        price = json["price"];
}

class Api extends GetConnect {
  Future<Response> getPriceList() =>
      get("https://api.preciodelaluz.org/v1/prices/all?zone=PCB");
}
