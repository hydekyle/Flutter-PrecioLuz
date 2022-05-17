import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:get/get.dart';

class PriceList extends StatelessWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Get.find<AppController>();
    return Center(
      child: ElevatedButton(
        child: const Text("Consultar"),
        onPressed: () => box.getPriceList(),
      ),
    );
  }
}
