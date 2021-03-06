import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';

class MenuBottomSheet extends StatelessWidget {
  final GraphicType selectedGraphicType;
  final RegionZone selectedRegionZone;
  const MenuBottomSheet({
    Key? key,
    required this.selectedGraphicType,
    required this.selectedRegionZone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightBar = context.height * 0.1;
    final heightButton = heightBar * 0.5;
    final colorButton = Theme.of(context).buttonColor;
    final box = Get.find<AppController>();
    return SizedBox(
      height: heightBar,
      width: context.width,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    const Text('GRÁFICO'),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: heightButton,
                            child: GestureDetector(
                              onTap: () {
                                box.selectedGraphicType.value =
                                    GraphicType.chart;
                                AppController.saveUserPreference(
                                  "selected-price-view",
                                  EnumToString.convertToString(
                                      GraphicType.chart),
                                );
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: colorButton),
                                  color:
                                      selectedGraphicType == GraphicType.chart
                                          ? colorButton
                                          : null,
                                ),
                                child: const Icon(Icons.bar_chart_sharp),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: heightButton,
                            child: GestureDetector(
                              onTap: () {
                                box.selectedGraphicType.value =
                                    GraphicType.wheel;
                                AppController.saveUserPreference(
                                  "selected-price-view",
                                  EnumToString.convertToString(
                                      GraphicType.wheel),
                                );
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: colorButton),
                                  color:
                                      selectedGraphicType == GraphicType.wheel
                                          ? colorButton
                                          : null,
                                ),
                                child: const Icon(Icons.access_time_rounded),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    const Text('REGIÓN'),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: heightButton,
                            child: GestureDetector(
                              onTap: () {
                                box.selectedRegionZone.value = RegionZone.PCB;
                                AppController.saveUserPreference(
                                  "selected-region",
                                  EnumToString.convertToString(
                                    RegionZone.PCB,
                                  ),
                                );
                                Get.back();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: colorButton),
                                  color: selectedRegionZone == RegionZone.PCB
                                      ? colorButton
                                      : null,
                                ),
                                child: const Text("PCB"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: heightButton,
                            child: GestureDetector(
                              onTap: () {
                                box.selectedRegionZone.value = RegionZone.CYM;
                                AppController.saveUserPreference(
                                  "selected-region",
                                  EnumToString.convertToString(
                                    RegionZone.CYM,
                                  ),
                                );
                                Get.back();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: colorButton),
                                  color: selectedRegionZone == RegionZone.CYM
                                      ? colorButton
                                      : null,
                                ),
                                child: const Text("CYM"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
