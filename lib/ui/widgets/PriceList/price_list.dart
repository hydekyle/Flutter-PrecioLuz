import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';
import 'package:get/get.dart';

class PriceList extends StatelessWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Get.find<AppController>();
    return Center(
      child: Column(
        children: [
          Flexible(
            flex: 5,
            child: SizedBox(
              child: Obx(
                () => PieChart(
                  PieChartData(
                    sections: getSections(box.priceList),
                  ),
                  swapAnimationCurve: Curves.easeIn, // Optional
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: ElevatedButton(
              onPressed: () => box.getTodayPriceDataList(),
              child: const Text("Press me"),
            ),
          ),
        ],
      ),
    );
  }

  getSections(List<PriceData> priceList) {
    if (priceList.isEmpty) return;
    List<PieChartSectionData> sectionList = <PieChartSectionData>[];
    var orderedList = <PriceData>[...priceList];
    orderedList.sort((a, b) => a.price.compareTo(b.price));
    var min = orderedList.first.price;
    var max = orderedList.last.price;
    var dif = max - min;
    for (var element in priceList) {
      var cheapRate = (max - element.price) / dif;
      print("$cheapRate:${element.price}:${element.hour}");
      sectionList.add(PieChartSectionData(
        title: element.hour,
        color: getColorByCheapRate(cheapRate),
        badgeWidget: getBadgeByCheapRate(cheapRate),
        badgePositionPercentageOffset: 1,
      ));
    }
    return sectionList;
  }

  getBadgeByCheapRate(double cheapRate) {
    if (cheapRate == 0.0) return const Icon(Icons.abc);
    if (cheapRate == 1.0) return const Icon(Icons.abc);
  }

  getColorByCheapRate(double cheapRate) {
    return Color.lerp(Colors.red, Colors.green, cheapRate);
  }
}
