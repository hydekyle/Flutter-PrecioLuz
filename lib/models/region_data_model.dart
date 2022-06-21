import 'price_data_model.dart';

class RegionData {
  var priceList = List<PriceData>.empty(growable: true);
  var minPriceData = PriceData.empty(), maxPriceData = PriceData.empty();
  var units = "€/Mwh";
  var minRounded = 0.0, maxRounded = 0.0, halfRounded = 0.0;
}
