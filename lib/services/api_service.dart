import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class Api extends GetConnect {
  Future<Response> getPriceList() =>
      get("https://api.preciodelaluz.org/v1/prices/all?zone=PCB");
}
