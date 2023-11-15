import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/utils/serverconfig_utils.dart';

class AssetService {
  static Future<List<dynamic>> getasset(String symbol) async {
    print(symbol);
    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.GET_ASSET}");

      var requestBody = {
        'symbol': symbol,
      };

      print(url);
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );
      print(requestBody);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // List<String> fetchedSymbols = List<String>.from(data);

        if (symbol == 'allwithdata') {
          List<Map<String, dynamic>> data =
              List<Map<String, dynamic>>.from(json.decode(response.body));
          return data;
        }

        List<String> fetchedSymbols = List<String>.from(data);
        print(fetchedSymbols);

        return fetchedSymbols;
      } else {
        throw Exception('Failed to load symbols');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  static Future<List<Map<String, dynamic>>> getassets(String symbol) async {
    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.GET_ASSET}");

      var requestBody = {
        'symbol': symbol,
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        return data;
      } else {
        throw Exception('Failed to load symbols');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
}
