import 'dart:convert';
import 'package:flutter_precio_luz/controllers/alarm_controller.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';
import 'package:flutter_precio_luz/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  late final SharedPreferences storage;
  final List<PriceData> priceList = List<PriceData>.empty().obs;
  final Api api = Api();
  final AlarmManager alarmManager = AlarmManager();
  final navbarIndex = 0.obs;

  init() async {
    storage = await SharedPreferences.getInstance();
    alarmManager.init();
    getTodayPriceDataList();
  }

  getTodayPriceDataList() async {
    _loadPriceList();
  }

  _loadPriceList() async {
    if (priceList.isNotEmpty) return;
    var response = await api.getPriceList();
    final dataEncoded = jsonEncode(response.body);
    final Map<String, dynamic> jsonData = jsonDecode(dataEncoded);
    priceList.clear();
    jsonData.forEach((key, value) async {
      var price = PriceData.fromJSON(value);
      priceList.add(price);
      await Future.delayed(const Duration(seconds: 1));
    });
  }
}
