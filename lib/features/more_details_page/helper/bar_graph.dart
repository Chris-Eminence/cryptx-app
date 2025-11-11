import 'package:cryptx/constants/colors.dart';
import 'package:cryptx/features/more_details_page/helper/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklySummary;

  const MyBarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunData: weeklySummary[0],
      monData: weeklySummary[1],
      tueData: weeklySummary[2],
      wedData: weeklySummary[3],
      thuData: weeklySummary[4],
      friData: weeklySummary[5],
      satData: weeklySummary[6],
    );

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        maxY: 100,
        minY: 0,
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(toY: data.y, color: kPrimaryPurpleColor),
                ],
              ),
            )
            .toList(),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(sideTitles: SideTitles( showTitles: true, getTitlesWidget: bottomTitleWidgets)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: leftTitleWidgets, reservedSize: 50)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false),
          ),

        )
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
    return SideTitleWidget(
      meta: meta,
       child: text,
    );


  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,);
    Widget text;
    text = Text("${value.toInt().toString()}k", style: style);
    return SideTitleWidget(
      //make the numbers fit the side and not overlap
       meta: meta,
      child: text,
    );
  }



}
