import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/utils/serverconfig_utils.dart';

class AssetService {
  static Timer? _timer;

  static Future<List<dynamic>> getasset(String symbol) async {
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
        List<dynamic> data = json.decode(response.body);

        if (symbol == 'allwithdata') {
          List<Map<String, dynamic>> data =
              List<Map<String, dynamic>>.from(json.decode(response.body));
          return data;
        }

        List<String> fetchedSymbols = List<String>.from(data);

        return fetchedSymbols;
      } else {
        throw Exception('Failed to load symbols');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

//experiment to cache data, due to delay
  static final Map<String, List<Map<String, dynamic>>> _cache = {};

  static Future<List<Map<String, dynamic>>> getassets(String symbol) async {
    try {
      if (_cache.containsKey(symbol)) {
        return _cache[symbol]!;
      }

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

        _cache[symbol] = data;

        return data;
      } else {
        throw Exception('Failed to load symbols');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

//fetch commodity prices //experimental
  static Future<List<Map<String, dynamic>>> getcommodity() async {
    try {
      if (_cache.containsKey('commodity')) {
        print("cache data sent commodity");
        return _cache['commodity']!;
      }

      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.GET_COMMODITY}");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        _cache['commodity'] = data;
        return data;
      } else {
        throw Exception('Failed to load symbols');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

//
  static void setupCacheTimer(String symbol) {
    // Set up a periodic timer for auto-refresh (every 5 minutes)
    if (_timer == null) {
      const Duration refreshDuration = Duration(minutes: 5);
      _timer = Timer.periodic(refreshDuration, (timer) async {
        await getassets(symbol);
      });
    }
  }
}
