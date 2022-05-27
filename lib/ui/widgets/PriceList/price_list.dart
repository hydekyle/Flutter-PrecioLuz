import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class PriceList extends StatelessWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Get.find<AppController>();
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: PaintCircle(),
          child: Container(),
        ),
        SizedBox(
          height: context.height / 3.2,
          child: Image.asset("images/AstroWheel.png"),
        ),
        Column(
          children: [
            Flexible(
              child: Obx(
                () => PieChart(
                  PieChartData(
                    sections: getSections(box.priceList),
                    startDegreeOffset: 90,
                    sectionsSpace: 1.5,
                  ),
                  swapAnimationCurve: Curves.easeIn,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  getSections(List<PriceData> priceList) {
    if (priceList.isEmpty) return;
    List<PieChartSectionData> sectionList = <PieChartSectionData>[];
    final box = Get.find<AppController>();
    var max = box.maxPrice.value;
    var min = box.minPrice.value;
    var dif = max - min;
    for (var element in priceList) {
      var cheapRate = (max - element.price) / dif;
      print("${cheapRate.toPrecision(2)}:${element.price}:${element.hour}");
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
    if (cheapRate == 0.0)
      return const Icon(Icons.warning_amber_outlined, color: Colors.yellow);
    if (cheapRate == 1.0)
      return const Icon(Icons.lightbulb_outline, color: Colors.blue);
  }

  getColorByCheapRate(double cheapRate) {
    return Color.lerp(Colors.red, Colors.green, cheapRate);
  }
}

class PaintCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color.fromARGB(255, 255, 225, 0),
          Color.fromARGB(171, 35, 0, 212),
        ],
      ).createShader(Rect.fromCircle(
        center: size.topCenter(Offset(0, size.height / 10)),
        radius: size.height * 1.1,
      ));
    canvas.drawCircle(
      size.center(Offset.zero),
      size.width / 1.98,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
