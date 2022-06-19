import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../controllers/app_controller.dart';
import '../../models/region_data_model.dart';

class PriceChart extends StatelessWidget {
  final RegionData regionData;
  const PriceChart({
    Key? key,
    required this.regionData,
  }) : super(key: key);

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final priceList = regionData.priceList;
    final style = TextStyle(
      fontSize: 18,
      color: AppController.getColorByCheapRate(priceList
          .firstWhere((element) =>
              int.parse(element.hour.substring(0, 2)) == value.ceil())
          .cheapRate),
      fontWeight: FontWeight.bold,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(priceList[value.toInt()].hour.substring(0, 2) + "h",
          style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.white, fontSize: 12.0);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 0,
      child:
          value == 0 ? const Text("") : Text('${value.round()}€', style: style),
    );
  }

  List<FlSpot> getPriceSpotList() {
    List<FlSpot> spotList = [];
    for (var x = 0; x < regionData.priceList.length; x++) {
      spotList.add(FlSpot(x.toDouble(), regionData.priceList[x].price));
    }
    return spotList;
  }

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;
    final priceColors = regionData.priceList
        .map((e) => AppController.getColorByCheapRate(e.cheapRate))
        .toList();

    return AspectRatio(
      aspectRatio: 1.4,
      child: Padding(
        padding: const EdgeInsets.only(left: 1, right: 18),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: true),
            lineBarsData: [
              LineChartBarData(
                spots: getPriceSpotList(),
                gradient: LinearGradient(colors: priceColors),
                isCurved: true,
                barWidth: 6,
                belowBarData: BarAreaData(
                  show: true,
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                  spotsLine: BarAreaSpotsLine(show: true),
                  gradient: LinearGradient(
                      colors: priceColors
                          .map((e) =>
                              Color.fromRGBO(e.red, e.green, e.blue, 0.5))
                          .toList()),
                ),
                aboveBarData: BarAreaData(
                  show: true,
                  color: Colors.orange.withOpacity(0.6),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, v, barData, i) => FlDotSquarePainter(
                    size: 20,
                    strokeColor: Colors.yellowAccent,
                    strokeWidth: 2,
                    color: priceColors[i],
                  ),
                  checkToShowDot: (spot, barData) =>
                      spot.y == regionData.minPriceData.price ||
                      spot.y == regionData.maxPriceData.price,
                ),
              ),
            ],
            minY: 0,
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 24,
                  interval: 4,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                axisNameSize: 20,
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 50,
                  reservedSize: 50,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 6 || value == 4 || value == 5;
              },
            ),
          ),
        ),
      ),
    );
  }
}
