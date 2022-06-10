import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/ui/widgets/price_highest_and_lowest.dart';
import 'package:flutter_precio_luz/ui/widgets/price_wheel.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
      body: GetBuilder<AppController>(
        init: AppController()..init(),
        builder: (box) => Obx(
          () => box.priceList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 18, 0, 4),
                            child: Text(
                              "HOY\n${box.priceList.first.date}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: PriceMinAndMax(
                              min: box.minPriceData.value,
                              max: box.maxPriceData.value,
                              cheapIcon: cheapIcon,
                              expensiveIcon: expensiveIcon,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).backgroundColor),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(Icons.menu),
                                  ),
                                  onPressed: () => showMaterialModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  child: Text(
                                    "Tarifa PVPC\n${box.regionZone.value == RegionZone.PCB ? 'Península, Canarias y Baleares' : 'Ceuta y Melilla'}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
