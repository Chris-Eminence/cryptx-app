
import 'dart:convert';
import 'package:cryptx/features/homepage/model/crypto_data_model.dart';
import 'package:http/http.dart' as http;

class GetCoinDataRepo{


  Future<void> fetchData() async {
    const String url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd';
    const String apiKey = 'CG-4Cxps3FwgXWKEA6L9CyX5pez';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-cg-demo-api-key' : 'Bearer $apiKey', // or just apiKey depending on API
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        List<CryptoDataModel> coins = CryptoDataModel.listFromJson(data);

        // Example: print coin names
        for (var c in coins) {
          print('${c.name} → ${c.currentPrice}');
        }
      } else {
        print('Request failed: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

}