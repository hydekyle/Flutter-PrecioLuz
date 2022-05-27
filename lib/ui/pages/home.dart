import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/ui/widgets/NavbarBottom/navbar_bottom.dart';
import 'package:flutter_precio_luz/ui/widgets/PriceHighestAndLowest/price_highest_and_lowest.dart';
import 'package:flutter_precio_luz/ui/widgets/PriceList/price_list.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: bodyHome()),
      bottomNavigationBar: const NavbarButtom(),
    );
  }

  Widget bodyHome() {
    final box = Get.find<AppController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 8,
          child: Stack(
            children: [
              Container(
                color: Colors.black,
                child: const PriceList(),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
              color: Colors.red, child: const PriceHighestAndLowest()),
        ),
        ElevatedButton(
          onPressed: () => box.getTodayPriceDataList(),
          child: const Text("Press me"),
        ),
      ],
    );
  }
}
