import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/market_chart_model.dart';

class MarketChartRepo {
  final String? _apiKey = dotenv.env['API_KEY'];

  /// Fetch market chart data for a coin over a number of days with caching
  Future<MarketChartModel?> getMarketChart(String id, {int days = 7}) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'market_chart_${id}_$days';

    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=usd&days=$days',
    );

    try {
      // 🟢 Try fetching from network first
      final response = await http.get(
        url,
        headers: {'x-cg-demo-api-key': _apiKey!},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // 🟢 Save to cache
        await prefs.setString(cacheKey, json.encode(jsonData));

        return MarketChartModel.fromJson(jsonData);
      } else {
        print('Failed to fetch market chart. Status code: ${response.statusCode}');
        return _loadFromCache(prefs, cacheKey);
      }
    } catch (e) {
      print('Error fetching market chart: $e');
      return _loadFromCache(prefs, cacheKey);
    }
  }

  /// Load cached market chart data
  MarketChartModel? _loadFromCache(SharedPreferences prefs, String cacheKey) {
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      final Map<String, dynamic> jsonData = json.decode(cachedData);
      return MarketChartModel.fromJson(jsonData);
    }
    return null;
  }
}
