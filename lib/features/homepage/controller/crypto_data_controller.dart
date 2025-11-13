import 'package:cryptx/features/homepage/model/crypto_data_model.dart';
import 'package:cryptx/features/homepage/repo/get_coin_data_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'crypto_data_state.dart';

class CryptoDataController extends StateNotifier<CryptoDataState> {
  final GetCoinDataRepo _repo;

  CryptoDataController(this._repo) : super(CryptoDataState.loading()) {
    fetchCoins();
  }

  void toggleFavourite(String cryptoId) {
    state = state.copyWith(
      data: state.data.map((crypto) {
        if (crypto.id == cryptoId) {
          return crypto.toggleFavourite();
        }
        return crypto;
      }).toList(),
    );
  }

// Optional: Get only favourites
  List<CryptoDataModel> get favourites {
    return state.data.where((crypto) => crypto.isFavourite).toList();
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
      // If cached data exists, the repo will already return it.
      // So this only triggers if both network and cache fail.
      state = CryptoDataState.error('Unable to load data. Please connect to the internet.');
    }
  }
}
