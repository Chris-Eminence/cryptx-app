import 'package:cryptx/features/more_details_page/repo/chart_repo.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'marrket_chart_state.dart';

class MarketChartNotifier extends StateNotifier<MarketChartState> {
  MarketChartNotifier(this._repo) : super(MarketChartInitial());

  final MarketChartRepo _repo;

  Future<void> fetchChart(String cryptoId, {int days = 7}) async {
    state = MarketChartLoading();

    final data = await _repo.getMarketChart(cryptoId, days: days);
    if (data != null) {
      state = MarketChartLoaded(data);
    } else {
      state = MarketChartError("Failed to load market chart data.");
    }
  }
}
