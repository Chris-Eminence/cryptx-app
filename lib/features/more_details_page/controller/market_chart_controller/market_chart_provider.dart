import 'package:cryptx/features/more_details_page/controller/market_chart_controller/market_chart_controller.dart';
import 'package:cryptx/features/more_details_page/controller/market_chart_controller/marrket_chart_state.dart';
import 'package:cryptx/features/more_details_page/repo/chart_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final marketChartRepoProvider = Provider((ref) => MarketChartRepo());

final marketChartNotifierProvider =
StateNotifierProvider<MarketChartNotifier, MarketChartState>((ref) {
  final repo = ref.watch(marketChartRepoProvider);
  return MarketChartNotifier(repo);
});
