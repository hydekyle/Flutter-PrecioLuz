import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/ui/widgets/NavbarBottom/navbar_bottom.dart';
import 'package:flutter_precio_luz/ui/widgets/PriceHighestAndLowest/price_highest_and_lowest.dart';
import 'package:flutter_precio_luz/ui/widgets/PriceList/price_list.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final cheapIcon = const Icon(
    Icons.stars_rounded,
    color: Colors.green,
  );
  final expensiveIcon = const Icon(
    Icons.warning_rounded,
    color: Colors.red,
  );

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
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        "HOY\n${box.priceList.first.date}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: PriceWheel(
                        priceList: box.priceList,
                        cheapIcon: cheapIcon,
                        expensiveIcon: expensiveIcon,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: PriceMinAndMax(
                        min: box.minPriceData.value,
                        max: box.maxPriceData.value,
                        cheapIcon: cheapIcon,
                        expensiveIcon: expensiveIcon,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
