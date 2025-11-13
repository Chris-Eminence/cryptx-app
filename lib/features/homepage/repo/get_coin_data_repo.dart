// lib/features/homepage/repo/get_coin_data_repo.dart

import 'dart:convert';
import 'package:cryptx/features/homepage/model/crypto_data_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetCoinDataRepo {
  final String? _apiKey = dotenv.env['API_KEY'];
  static const String _cacheKey = 'cached_crypto_data';

  Future<List<CryptoDataModel>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    const String url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd';

    try {
      // Try fetching data from the internet
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-cg-demo-api-key': _apiKey!,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Decode and cache the response
        List data = jsonDecode(response.body);

        // Save to SharedPreferences as a string
        await prefs.setString(_cacheKey, jsonEncode(data));

        // Return parsed model list
        return CryptoDataModel.listFromJson(data);
      } else {
        // If server error, try loading cached data
        return _loadCachedData(prefs);
      }
    } catch (e) {
      // If no internet or any other error, try loading cached data
      return _loadCachedData(prefs);
    }
  }

  Future<List<CryptoDataModel>> _loadCachedData(SharedPreferences prefs) async {
    final cachedData = prefs.getString(_cacheKey);
    if (cachedData != null) {
      List data = jsonDecode(cachedData);
      return CryptoDataModel.listFromJson(data);
    } else {
      throw Exception('No cached data available');
    }
  }
}
