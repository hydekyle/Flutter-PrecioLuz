import 'price_data_model.dart';

class RegionData {
  var priceList = List<PriceData>.empty(growable: true);
  var minPriceData = PriceData.empty(), maxPriceData = PriceData.empty();
}
