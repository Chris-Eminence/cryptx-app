import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/more_info_model.dart';

class MoreInfoRepo {
  // You can store the API key here internally
  final String _apiKey = 'CG-4Cxps3FwgXWKEA6L9CyX5pez';

  Future<MoreInfoModel?> getMoreInfo(String id) async {
    final url = Uri.parse('https://api.coingecko.com/api/v3/coins/$id');

    final response = await http.get(
      url,
      headers: {
        'x-cg-demo-api-key': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return MoreInfoModel.fromJson(jsonData);
    } else {
      print('Failed to load data for $id. Status code: ${response.statusCode}');
      return null;
    }
  }
}
