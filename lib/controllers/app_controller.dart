// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:flutter_precio_luz/models/price_data_model.dart';
import 'package:flutter_precio_luz/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum PriceViewType { circular, chart }
enum RegionZone { PCB, CYM }

class AppController extends GetxController {
  late final SharedPreferences storage;
  final Api api = Api();
  final priceViewType = PriceViewType.circular.obs;
  final regionZone = RegionZone.PCB.obs;
  final priceList = List<PriceData>.empty().obs;
  final minPriceData = PriceData.empty().obs,
      maxPriceData = PriceData.empty().obs;

  init() async {
    storage = await SharedPreferences.getInstance();
    loadUserPreferences();
    getTodayPriceDataList();
  }

  loadUserPreferences() {
    if (storage.containsKey("selected-price-view")) {
      final _priceViewType = storage.getString("selected-price-view")!;
      priceViewType.value =
          EnumToString.fromString(PriceViewType.values, _priceViewType)!;
    }
    if (storage.containsKey("selected-zone")) {
      final _regionZone = storage.getString("selected-zone")!;
      regionZone.value =
          EnumToString.fromString(RegionZone.values, _regionZone)!;
    }
  }

  getTodayPriceDataList() async {
    _loadPriceList();
  }

  _loadPriceList() async {
    final zone = EnumToString.convertToString(regionZone.value);
    final response = await api.getPriceList(zone);
    final dataEncoded = jsonEncode(response.body);
    final Map<String, dynamic> jsonData = jsonDecode(dataEncoded);
    priceList.clear();
    jsonData.forEach((key, value) {
      var price = PriceData.fromJSON(value);
      priceList.add(price);
      print(value);
    });
    var orderedList = <PriceData>[...priceList];
    orderedList.sort((a, b) => a.price.compareTo(b.price));
    minPriceData.value = orderedList.first;
    maxPriceData.value = orderedList.last;
  }
}
