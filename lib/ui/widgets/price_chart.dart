import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/price_data_model.dart';

class PriceChart extends StatelessWidget {
  final List<PriceData> priceList;
  const PriceChart({
    Key? key,
    required this.priceList,
  }) : super(key: key);

  Widget bottomTitleWidgets(double value, TitleMeta meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: Text(priceList[value.toInt()].hour.substring(0, 2) + "h",
            style: _dateTextStyle),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 12.0);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('\$ ${value + 0.5}', style: style),
    );
  }

  List<FlSpot> getPriceSpotList() {
    List<FlSpot> spotList = [];
    for (var x = 0; x < priceList.length; x++) {
      spotList.add(FlSpot(x.toDouble(), priceList[x].price));
    }
    return spotList;
  }

  static const _dateTextStyle = TextStyle(
    fontSize: 10,
    color: Colors.purple,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;

    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(left: 1, right: 12),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: getPriceSpotList(),
                isCurved: true,
                barWidth: 8,
                color: Colors.purpleAccent,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.deepPurple.withOpacity(0.4),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: true,
                  color: Colors.orange.withOpacity(0.6),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: false,
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
                axisNameWidget: const Text(
                  '2019',
                  style: _dateTextStyle,
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 18,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                axisNameSize: 20,
                axisNameWidget: const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text('Value'),
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 40,
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
