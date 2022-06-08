import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/ui/widgets/NavbarBottom/navbar_bottom.dart';
import 'package:flutter_precio_luz/ui/widgets/PriceHighestAndLowest/price_highest_and_lowest.dart';
import 'package:flutter_precio_luz/ui/widgets/PriceList/price_list.dart';
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
    return GetBuilder<AppController>(
      init: AppController()..init(),
      builder: (box) => Obx(
        () => box.priceList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 8,
                    child: PriceWheel(priceList: box.priceList),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                        color: Colors.red,
                        child: const PriceHighestAndLowest()),
                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () => box.getTodayPriceDataList(),
                      child: const Text("Press me"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
