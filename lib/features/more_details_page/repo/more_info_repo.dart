import 'dart:convert';
import 'package:cryptx/features/more_details_page/model/more_info_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MoreInfoRepo {
  final String? _apiKey = dotenv.env['API_KEY'];

  Future<MoreInfoModel?> getMoreInfo(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = "more_info_$id";

    final url = Uri.parse('https://api.coingecko.com/api/v3/coins/$id');

    try {
      // 🟩 Try to fetch from network first
      final response = await http.get(
        url,
        headers: {
          'x-cg-demo-api-key': _apiKey!,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // 🟩 Save response to cache
        await prefs.setString(cacheKey, json.encode(jsonData));

        return MoreInfoModel.fromJson(jsonData);
      } else {
        print("Server error: ${response.statusCode}");

        // 🔶 Try fallback to cache
        if (prefs.containsKey(cacheKey)) {
          final cachedData = prefs.getString(cacheKey);
          if (cachedData != null) {
            return MoreInfoModel.fromJson(json.decode(cachedData));
          }
        }

        return null;
      }
    } catch (e) {
      print("Network error: $e");

      // 🔶 Offline fallback: return cached data
      if (prefs.containsKey(cacheKey)) {
        final cachedData = prefs.getString(cacheKey);
        if (cachedData != null) {
          return MoreInfoModel.fromJson(json.decode(cachedData));
        }
      }

      return null;
    }
  }
}
