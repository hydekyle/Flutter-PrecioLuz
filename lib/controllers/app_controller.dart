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
  final Api api = Api();
  final regionDataDic = <RegionZone, RegionData>{};
  final selectedGraphicType = GraphicType.wheel.obs;
  final selectedRegionZone = RegionZone.PCB.obs;
  final isDataLoaded = false.obs;

  final cheapIcon = const Icon(
    Icons.stars_rounded,
    color: Colors.green,
  );
  final expensiveIcon = const Icon(
    Icons.warning_rounded,
    color: Colors.red,
  );

  init() async {
    storage = await SharedPreferences.getInstance();
    loadUserPreferences();
    _getTodayPriceDataList();
  }

  RegionData getRegionData() => regionDataDic[selectedRegionZone.value]!;

  loadUserPreferences() {
    if (storage.containsKey("selected-price-view")) {
      final _priceViewType = storage.getString("selected-price-view")!;
      selectedGraphicType.value =
          EnumToString.fromString(GraphicType.values, _priceViewType)!;
    }
    if (storage.containsKey("selected-zone")) {
      final _regionZone = storage.getString("selected-zone")!;
      selectedRegionZone.value =
          EnumToString.fromString(RegionZone.values, _regionZone)!;
    }
  }

  _getTodayPriceDataList() async {
    for (var regionZone in RegionZone.values) {
      final zoneString = EnumToString.convertToString(regionZone);
      final response = await api.getPriceList(zoneString);
      final dataEncoded = jsonEncode(response.body);
      final Map<String, dynamic> jsonData = jsonDecode(dataEncoded);
      // Obter lista de precios
      final regionData = regionDataDic[regionZone] = RegionData();
      jsonData.forEach((key, value) {
        var price = PriceData.fromJSON(value);
        regionData.priceList.add(price);
        print(value);
      });
      // Calcular max y min
      var orderedList = <PriceData>[...regionData.priceList];
      orderedList.sort((a, b) => a.price.compareTo(b.price));
      regionData.minPriceData = orderedList.first;
      regionData.maxPriceData = orderedList.last;
    }
    isDataLoaded.value = true;
  }
}
