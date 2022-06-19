// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';
import 'package:flutter_precio_luz/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enum_to_string/enum_to_string.dart';
import '../models/region_data_model.dart';

enum GraphicType { wheel, chart }
enum RegionZone { PCB, CYM }

class AppController extends GetxController {
  late final SharedPreferences storage;
  final Api _api = Api();
  final _regionDataDic = <RegionZone, RegionData>{};
  final selectedGraphicType = GraphicType.chart.obs;
  final selectedRegionZone = RegionZone.PCB.obs;
  final isDataLoaded = false.obs;

  final iconCheap = const Icon(
    Icons.stars_rounded,
    color: Colors.green,
  );
  final iconExpensive = const Icon(
    Icons.warning_rounded,
    color: Colors.red,
  );

  init() async {
    storage = await SharedPreferences.getInstance();
    _loadUserPreferences();
    _getTodayPriceDataList();
  }

  RegionData getRegionData() => _regionDataDic[selectedRegionZone.value]!;

  _loadUserPreferences() {
    if (storage.containsKey("selected-price-view")) {
      final _priceViewType = storage.getString("selected-price-view")!;
      selectedGraphicType.value =
          EnumToString.fromString(GraphicType.values, _priceViewType)!;
    }
    if (storage.containsKey("selected-region")) {
      final _regionZone = storage.getString("selected-region")!;
      selectedRegionZone.value =
          EnumToString.fromString(RegionZone.values, _regionZone)!;
    }
  }

  static saveUserPreference(String key, String value) {
    final box = Get.find<AppController>();
    box.storage.setString(key, value);
  }

  _getTodayPriceDataList() async {
    for (var regionZone in RegionZone.values) {
      final zoneString = EnumToString.convertToString(regionZone);
      final response = await _api.getPriceList(zoneString);
      final dataEncoded = jsonEncode(response.body);
      final Map<String, dynamic> jsonData = jsonDecode(dataEncoded);
      // Obter lista de precios
      final regionData = _regionDataDic[regionZone] = RegionData();
      jsonData.forEach((key, value) {
        var priceData = PriceData.fromJSON(value);
        regionData.priceList.add(priceData);
        print(value);
      });
      // Calcular max y min
      var orderedList = <PriceData>[...regionData.priceList];
      orderedList.sort((a, b) => a.price.compareTo(b.price));
      var min = regionData.minPriceData = orderedList.first;
      var max = regionData.maxPriceData = orderedList.last;
      var dif = max.price - min.price;
      // Calcular CheapRates
      for (var element in regionData.priceList) {
        element.cheapRate = (max.price - element.price) / dif;
      }
    }
    isDataLoaded.value = true;
  }

  static Widget? getBadgeByCheapRate(double cheapRate) {
    final box = Get.find<AppController>();
    if (cheapRate == 0.0) return box.iconExpensive;
    if (cheapRate == 1.0) return box.iconCheap;
    return null;
  }

  static Color getColorByCheapRate(double cheapRate) {
    return Color.lerp(Colors.red, Colors.green, cheapRate)!;
  }
}
