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
    return Center(
      child: Stack(
        children: [
          CustomPaint(
            painter: PaintNightArc(),
            foregroundPainter: PaintDayArc(),
            child: Container(),
          ),
          Center(
            child: Container(
              height: context.height / 3.2,
              margin: EdgeInsets.only(bottom: context.height / 2.35),
              child: Image.asset("images/AstroWheel.png"),
            ),
          ),
          Column(
            children: [
              Flexible(
                flex: 5,
                child: SizedBox(
                  child: Obx(
                    () => PieChart(
                      PieChartData(
                        sections: getSections(box.priceList),
                        startDegreeOffset: 90,
                        sectionsSpace: 1.5,
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
          )
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

class PaintNightArc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color.fromARGB(255, 184, 184, 184),
          Color.fromARGB(98, 225, 255, 135),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset.zero,
        radius: size.height / 6,
      ));
    canvas.translate(size.width / 2, size.height / 4);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset.zero,
        height: size.height / 2.5,
        width: size.width / 1.5,
      ),
      math.pi,
      math.pi,
      false,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PaintDayArc extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..style = PaintingStyle.fill
      ..shader = const RadialGradient(
        colors: [
          Color.fromARGB(255, 232, 231, 231),
          Color.fromARGB(126, 39, 37, 133),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset.zero,
        radius: size.height / 6,
      ));
    canvas.translate(size.width / 2, size.height / 4);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset.zero,
        height: size.height / 2.5,
        width: size.width / 1.5,
      ),
      0,
      math.pi,
      false,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
