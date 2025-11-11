// lib/features/homepage/repo/get_coin_data_repo.dart

import 'dart:convert';
import 'package:cryptx/features/homepage/model/crypto_data_model.dart';
import 'package:http/http.dart' as http;

class GetCoinDataRepo {
  Future<List<CryptoDataModel>> fetchData() async {
    const String url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd';
    const String apiKey = 'CG-4Cxps3FwgXWKEA6L9CyX5pez';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'x-cg-demo-api-key': apiKey,
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return CryptoDataModel.listFromJson(data);
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}
