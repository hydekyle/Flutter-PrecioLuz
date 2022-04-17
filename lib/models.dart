import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  late final SharedPreferences storage;
  final List<Price> priceList = List<Price>.empty().obs;
  final Api api = Api();

  init() async {
    storage = await SharedPreferences.getInstance();
    loadPriceList();
  }

  loadPriceList() async {
    var response = await api.getPriceList();
    final dataEncoded = jsonEncode(response.body);
    final Map<String, dynamic> data = jsonDecode(dataEncoded);
    priceList.clear();
    data.forEach((key, value) {
      var price = Price.fromJSON(value);
      priceList.add(price);
      print(price.hour);
    });
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
