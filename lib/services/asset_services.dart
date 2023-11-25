import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetService {
  static Timer? _timer;
  // ignore: unused_field
  static const String _cacheKey = 'asset_cache';

  static void startGlobalTimer() {
    if (_timer == null) {
      const Duration refreshDuration = Duration(minutes: 5);
      _timer = Timer.periodic(refreshDuration, (timer) async {
        await refreshAllFunctions();
      });
    }
  }

  static Future<void> refreshAllFunctions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Refreshing data");

      print("Refreshing getassets");
      prefs.remove('asset_NABIL');
      await getasset('NABIL');

      print("getassets('allwithdata')");
      prefs.remove('asset_cache');
      await getassets('allwithdata');

      print("getcommodity");
      prefs.remove('commodity_cache');
      await getcommodity();

      print("getMetal");
      prefs.remove('metal_cache');
      await getMetal();

      // prefs.remove('metal_history_cache');
      // await getAssetHistory();

      print("gettrending");
      prefs.remove('trending_cache');
      await gettrending();

      print("getturnover");
      prefs.remove('turnover_cache');
      await getturnover();

      print("getvolume");
      prefs.remove('topvolume_cache');
      await getvolume();
    } catch (error) {
      print("Error occured while refreshing data");
      CustomToast.showToast("Error refreshing functions");
    }
  }

  static Future<List<dynamic>> getasset(String symbol) async {
    try {
      final String cacheKey = 'asset_$symbol';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<dynamic> data = json.decode(cachedData);

        return data;
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
        List<dynamic> data = json.decode(response.body);

        prefs.setString(cacheKey, json.encode(data));

        return data;
      } else {
        throw Exception('Failed to load symbols');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

// new approach to save cache in shared preferenses
  static Future<List<Map<String, dynamic>>> getassets(String symbol) async {
    try {
      const String cacheKey = 'asset_cache';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(cachedData));

        return data;
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

        prefs.setString(cacheKey, json.encode(data));

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
      const String cacheKey = 'commodity_cache';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(cachedData));

        return data;
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

        prefs.setString(cacheKey, json.encode(data));

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
      const String cacheKey = 'metal_cache';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(cachedData));

        return data;
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

          prefs.setString(cacheKey, json.encode(data));

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
  static Future<List<Map<String, dynamic>>> getAssetHistory(
      String assetName) async {
    try {
      const String cacheKey = 'metal_history_cache';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(cachedData));

        return data;
      }

      var requestData = {
        'assetName': assetName,
      };

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

          prefs.setString(cacheKey, json.encode(data));

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
      const String cacheKey = 'trending_cache';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(cachedData));

        return data;
      }
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

        prefs.setString(cacheKey, json.encode(data));

        return data;
      } else {
        throw Exception('Failed to load trending');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

//turnover
  static Future<List<Map<String, dynamic>>> getturnover() async {
    try {
      const String cacheKey = 'turnover_cache';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(cachedData));

        return data;
      }
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.TURNOVER}");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        prefs.setString(cacheKey, json.encode(data));

        return data;
      } else {
        throw Exception('Failed to load turnover');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

//top volume
  static Future<List<Map<String, dynamic>>> getvolume() async {
    try {
      const String cacheKey = 'topvolume_cache';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(cachedData));

        return data;
      }
      var url =
          Uri.parse("${ServerConfig.SERVER_ADDRESS}${ServerConfig.VOLUME}");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        prefs.setString(cacheKey, json.encode(data));

        return data;
      } else {
        throw Exception('Failed to load Volume');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  // static void _startCacheTimer(Function() callback) {
  //   if (_timer == null) {
  //     const Duration refreshDuration = Duration(minutes: 5);
  //     _timer = Timer.periodic(refreshDuration, (timer) async {
  //       callback();
  //     });
  //   }
  // }
}
