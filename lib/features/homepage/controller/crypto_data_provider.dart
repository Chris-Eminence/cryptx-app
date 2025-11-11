import 'package:cryptx/features/homepage/controller/crypto_data_controller.dart';
import 'package:cryptx/features/homepage/controller/crypto_data_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 import 'package:cryptx/features/homepage/repo/get_coin_data_repo.dart';
import 'package:flutter_riverpod/legacy.dart';

final coinDataProvider = Provider((ref) => GetCoinDataRepo());

final cryptoProvider =
StateNotifierProvider<CryptoDataController, CryptoDataState>((ref) {
  return CryptoDataController(ref.watch(coinDataProvider));
});
