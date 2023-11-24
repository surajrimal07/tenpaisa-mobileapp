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
        //print("cache data sent commodity");
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

// fetch metal prices
  static Future<List<Map<String, dynamic>>> getMetal() async {
    try {
      if (_cache.containsKey('metal')) {
        return _cache['metal']!;
      }

      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.METAL}");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('metalPrices')) {
          List<Map<String, dynamic>> data =
              List<Map<String, dynamic>>.from(responseData['metalPrices']);
          _cache['metal'] = data;
          return data;
        } else {
          throw Exception('Invalid backend response structure');
        }
      } else {
        throw Exception('Failed to load symbols');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

//metal hist
//bugged, make it more universal and just pass two data today and last 15 day data.
  static Future<List<Map<String, dynamic>>> getAssetHistory(
      String assetName) async {
    try {
      var requestData = {
        'assetName': assetName,
      };

      if (_cache.containsKey('$assetName-history')) {
        return _cache['$assetName-history']!;
      }

      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.METALHISTORY}");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('dates') &&
            responseData.containsKey('prices')) {
          List<Map<String, dynamic>> data = [
            {'dates': responseData['dates'], 'prices': responseData['prices']}
          ];
          _cache['$assetName-history'] = data;
          return data;
        } else {
          throw Exception('Invalid backend response structure');
        }
      } else {
        throw Exception('Failed to load historical data');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

//trending
  static Future<List<Map<String, dynamic>>> gettrending() async {
    try {
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.TRENDING}");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        return data;
      } else {
        throw Exception('Failed to load trending');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  static void setupCacheTimer(String symbol) {
    if (_timer == null) {
      const Duration refreshDuration = Duration(minutes: 5);
      _timer = Timer.periodic(refreshDuration, (timer) async {
        await getassets(symbol);
      });
    }
  }
}
