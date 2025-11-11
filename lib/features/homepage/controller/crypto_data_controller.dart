import 'package:cryptx/features/homepage/repo/get_coin_data_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'crypto_data_state.dart';

class CryptoDataController extends StateNotifier<CryptoDataState> {
  final GetCoinDataRepo _repo;

  CryptoDataController(this._repo) : super(CryptoDataState.loading()) {
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    state = CryptoDataState.loading();
    try {
      final coins = await _repo.fetchData();
      if (coins.isEmpty) {
        state = CryptoDataState.empty();
      } else {
        state = CryptoDataState.data(coins);
      }
    } catch (e) {
      state = CryptoDataState.error(e.toString());
    }
  }
}
