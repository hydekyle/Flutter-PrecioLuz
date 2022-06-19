import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/ui/widgets/price_highest_and_lowest.dart';
import 'package:flutter_precio_luz/ui/widgets/price_wheel.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/modal_bottom_sheet.dart';
import '../widgets/price_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AppController>(
        init: AppController()..init(),
        builder: (box) => Obx(
          () => !box.isDataLoaded.value
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            box.selectedRegionZone.value == RegionZone.PCB
                                ? 'Península, Canarias y Baleares'
                                : 'Ceuta y Melilla',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const Spacer(),
                        Flexible(
                          flex: 9,
                          child:
                              box.selectedGraphicType.value == GraphicType.wheel
                                  ? PriceWheel(regionData: box.getRegionData())
                                  : PriceChart(regionData: box.getRegionData()),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 18, 0, 4),
                            child: Text(
                              box.getRegionData().priceList.first.date,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child:
                                PriceMinAndMax(regionData: box.getRegionData()),
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
                                      expand: false,
                                      builder: (context) => Obx(
                                            () => MenuBottomSheet(
                                              selectedGraphicType:
                                                  box.selectedGraphicType.value,
                                              selectedRegionZone:
                                                  box.selectedRegionZone.value,
                                            ),
                                          )),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  child: const Text(
                                    "Tarifa PVPC",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
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
