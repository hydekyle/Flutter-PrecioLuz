import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';
import 'package:get/get.dart';
import '../../models/region_data_model.dart';

class PriceWheel extends StatelessWidget {
  final RegionData regionData;
  const PriceWheel({
    Key? key,
    required this.regionData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final priceList = regionData.priceList;
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
              child: PieChart(
                PieChartData(
                  sections: getSections(priceList),
                  startDegreeOffset: 90,
                ),
                swapAnimationCurve: Curves.easeIn,
              ),
            ),
          ],
        )
      ],
    );
  }

  getSections(List<PriceData> priceList) {
    List<PieChartSectionData> sectionList = <PieChartSectionData>[];
    for (var element in priceList) {
      sectionList.add(PieChartSectionData(
        title: "${element.hour.substring(0, 2)}h\n${element.price.toInt()}€",
        color: AppController.getColorByCheapRate(element.cheapRate),
        badgePositionPercentageOffset: -0.4,
        badgeWidget: AppController.getBadgeByCheapRate(element.cheapRate),
      ));
    }
    return sectionList;
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
