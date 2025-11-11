import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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

    return LineChart(
      LineChartData(
        minY: minY * 0.95,
        maxY: maxY * 1.05,
        gridData: FlGridData(show: true, horizontalInterval: (maxY - minY) / 5),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: 1,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (maxY - minY) / 5,
              getTitlesWidget: (value, meta) => Text(
                value.toStringAsFixed(0),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
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
            spots: spots,
            isCurved: true,
            color: Colors.green,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
