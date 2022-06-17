import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/price_data_model.dart';
import '../../controllers/app_controller.dart';

class PriceMinAndMax extends StatelessWidget {
  final PriceData min, max;
  const PriceMinAndMax({
    Key? key,
    required this.min,
    required this.max,
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
                      box.cheapIcon,
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
                    Text("${min.hour.substring(0, 2)}:00"),
                    const Spacer(),
                    Text(min.price.toString()),
                    Text(min.units),
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
                    Text("${max.hour.substring(0, 2)}:00"),
                    const Spacer(),
                    Text(max.price.toString()),
                    Text(max.units),
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
                      box.expensiveIcon,
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
