import 'package:cryptx/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';

class CryptoLineChart extends StatelessWidget {
  final List<double> prices; // list of price points
  const CryptoLineChart({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    if (prices.isEmpty) return const SizedBox();

    List<FlSpot> spots = [];
    for (int i = 0; i < prices.length; i++) {
      spots.add(FlSpot(i.toDouble(), prices[i]));
    }

    double minY = prices.reduce((a, b) => a < b ? a : b);
    double maxY = prices.reduce((a, b) => a > b ? a : b);

    // Days of the week labels
    final List<String> daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: LineChart(
        LineChartData(
          minY: minY * 0.95,
          maxY: maxY * 1.05,
          gridData: FlGridData(show: false, horizontalInterval: (maxY - minY) / 5),
          titlesData: FlTitlesData(
            // Hide top titles
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            // Hide right titles
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            // Bottom titles with days of the week
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            // Left titles showing only min and max values
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  // Only show labels for min and max values
                  if (value == meta.min || value == meta.max) {
                    return Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.white),
              left: BorderSide(color: Colors.white),
              right: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    kPrimaryPurpleColor,
                    kPrimaryPurpleColor.withOpacity(0.3),
                    kPrimaryPurpleColor.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                ),
              ),
              spots: spots,
              isCurved: true,
              color: kPrimaryPurpleColor,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Sun', style: style);
        break;
      case 1:
        text = const Text('Mon', style: style);
        break;
      case 2:
        text = const Text('Tue', style: style);
        break;
      case 3:
        text = const Text('Wed', style: style);
        break;
      case 4:
        text = const Text('Thu', style: style);
        break;
      case 5:
        text = const Text('Fri', style: style);
        break;
      case 6:
        text = const Text('Sat', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(meta: meta, child: text);
  }
}
