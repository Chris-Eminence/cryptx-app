import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/market_chart_model.dart'; // import your model

class MarketChartRepo {
  final String? _apiKey = dotenv.env['API_KEY'];

  /// Fetch market chart data for a coin over a number of days
  Future<MarketChartModel?> getMarketChart(String id, {int days = 7}) async {
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=usd&days=$days',
    );

    try {
      final response = await http.get(
        url,
        headers: {'x-cg-demo-api-key': _apiKey!},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return MarketChartModel.fromJson(jsonData);
      } else {
        print('Failed to fetch market chart. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching market chart: $e');
      return null;
    }
  }
}
