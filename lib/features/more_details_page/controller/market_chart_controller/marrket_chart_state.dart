import '../../model/market_chart_model.dart';

abstract class MarketChartState {}

class MarketChartInitial extends MarketChartState {}

class MarketChartLoading extends MarketChartState {}

class MarketChartLoaded extends MarketChartState {
  final MarketChartModel chartData;

  MarketChartLoaded(this.chartData);
}

class MarketChartError extends MarketChartState {
  final String message;

  MarketChartError(this.message);
}
