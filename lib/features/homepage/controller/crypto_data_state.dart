// lib/features/homepage/controller/crypto_data_state.dart

import 'package:cryptx/features/homepage/model/crypto_data_model.dart';

class CryptoDataState {
  final bool isLoading;
  final List<CryptoDataModel> data;
  final String? error;

  CryptoDataState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  factory CryptoDataState.loading() =>
      CryptoDataState(isLoading: true, data: [], error: null);

  factory CryptoDataState.data(List<CryptoDataModel> list) =>
      CryptoDataState(isLoading: false, data: list, error: null);

  factory CryptoDataState.empty() =>
      CryptoDataState(isLoading: false, data: [], error: null);

  factory CryptoDataState.error(String e) =>
      CryptoDataState(isLoading: false, data: [], error: e);
}
