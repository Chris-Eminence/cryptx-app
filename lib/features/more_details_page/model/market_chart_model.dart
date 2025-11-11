class MarketChartModel {
  final List<ChartDataPoint> prices;
  final List<ChartDataPoint> marketCaps;
  final List<ChartDataPoint> totalVolumes;

  MarketChartModel({
    required this.prices,
    required this.marketCaps,
    required this.totalVolumes,
  });

  factory MarketChartModel.fromJson(Map<String, dynamic> json) {
    return MarketChartModel(
      prices: (json['prices'] as List)
          .map((e) => ChartDataPoint.fromList(e))
          .toList(),
      marketCaps: (json['market_caps'] as List)
          .map((e) => ChartDataPoint.fromList(e))
          .toList(),
      totalVolumes: (json['total_volumes'] as List)
          .map((e) => ChartDataPoint.fromList(e))
          .toList(),
    );
  }
}

class ChartDataPoint {
  final DateTime time;
  final double value;

  ChartDataPoint({
    required this.time,
    required this.value,
  });

  /// Converts the array format [timestamp, value]
  factory ChartDataPoint.fromList(List<dynamic> list) {
    return ChartDataPoint(
      time: DateTime.fromMillisecondsSinceEpoch(list[0]),
      value: (list[1] as num).toDouble(),
    );
  }
}
