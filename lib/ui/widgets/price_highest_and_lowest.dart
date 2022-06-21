import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../models/region_data_model.dart';

class PriceMinAndMax extends StatelessWidget {
  final RegionData regionData;
  const PriceMinAndMax({
    Key? key,
    required this.regionData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Get.find<AppController>();
    return Row(
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 26, 138, 30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      box.iconCheap,
                      const Text(
                        "Precio más BAJO",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: const Color.fromARGB(255, 26, 138, 30),
                  child: Column(children: [
                    const Icon(Icons.alarm),
                    Text("${regionData.minPriceData.hour.substring(0, 2)}:00"),
                    const Spacer(),
                    Text(regionData.minPriceData.price.toString()),
                    Text(regionData.units),
                  ]),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: const Color.fromARGB(255, 189, 31, 20),
                  child: Column(children: [
                    const Icon(Icons.alarm),
                    Text("${regionData.maxPriceData.hour.substring(0, 2)}:00"),
                    const Spacer(),
                    Text(regionData.maxPriceData.price.toString()),
                    Text(regionData.units),
                  ]),
                ),
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 189, 31, 20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      box.iconExpensive,
                      const Text(
                        "Precio más ALTO",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
