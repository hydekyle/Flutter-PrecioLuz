import 'package:get/get_connect/connect.dart';

class Api extends GetConnect {
  Future<Response> getPriceList(String zone) =>
      get("https://api.preciodelaluz.org/v1/prices/all?zone=$zone");
}
