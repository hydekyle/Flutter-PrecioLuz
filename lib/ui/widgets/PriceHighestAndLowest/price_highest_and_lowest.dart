import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';
import 'package:get/get.dart';

class PriceHighestAndLowest extends StatelessWidget {
  const PriceHighestAndLowest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Get.find<AppController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.green,
            child: Text("Bajo"),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            color: Colors.red,
            child: Text("alto"),
          ),
        ),
      ],
    );
  }
}
