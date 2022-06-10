import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';

class PriceMinAndMax extends StatelessWidget {
  final PriceData min, max;
  final Icon cheapIcon, expensiveIcon;
  const PriceMinAndMax({
    Key? key,
    required this.min,
    required this.max,
    required this.cheapIcon,
    required this.expensiveIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      cheapIcon,
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
                      expensiveIcon,
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
