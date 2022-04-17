import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/models.dart';
import 'package:get/get.dart';
import 'controller.dart';

class PriceList extends StatelessWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Get.find<AppController>();
    return ElevatedButton(
      child: const Text("Consultar"),
      onPressed: () => box.loadPriceList(),
    );
  }
}
