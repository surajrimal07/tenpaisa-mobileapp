import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paisa/app/toast/flutter_toast.dart';
import 'package:paisa/model/asset_model.dart';
import 'package:paisa/services/news_service.dart';
import 'package:paisa/utils/serverconfig_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetService {
  static Timer? _timer;
  // ignore: unused_field
  static const String _cacheKey = 'asset_cache';

  static void startGlobalTimer() {
    if (_timer == null) {
      const Duration refreshDuration = Duration(minutes: 1);
      _timer = Timer.periodic(refreshDuration, (timer) async {
        await refreshAllFunctions();
      });
    }
  }

  static Future<void> refreshAllFunctions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //print("Refreshing data");

      //print("Refreshing getassets");
      // prefs.remove('asset_NABIL');
      // await getsingleasset('NABIL');

      //print("getassets('allwithdata')");
      prefs.remove('asset_cache');
      await getassets('allwithdata');

      //print("getcommodity");
      prefs.remove('commodity_cache');
      await getcommodity();

      //print("getMetal");
      prefs.remove('metal_cache');
      await getMetal();

      //print("gettrending");
      prefs.remove('trending_cache');
      await gettrending();

      //print("getturnover");
      prefs.remove('turnover_cache');
      await getturnover();

      //print("getvolume");
      prefs.remove('topvolume_cache');
      await getvolume();

      // refreshing news too
      prefs.remove('news_cache');
      await News.fetchNews();
    } catch (error) {
      //print("Error occured while refreshing data");
      CustomToast.showToast("Error refreshing functions");
    }
  }

  static Future<Map<String, dynamic>> getsingleasset(String symbol) async {
    try {
      var url = Uri.parse(
          "${ServerConfig.SERVER_ADDRESS}${ServerConfig.GET_SINGLEASSET}");
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
        Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load symbols');
      }
    } catch (error) {
      throw Exception('Single Asset error: $error');
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
}

//data providers

class TurnoverData {
  final List<Asset> turnoverData;
  TurnoverData(this.turnoverData);

  static Future<TurnoverData> getTurnoverData() async {
    try {
      List<Map<String, dynamic>> fetchedTurnoverMaps =
          await AssetService.getturnover();

      List<Asset> fetchedTurnover = fetchedTurnoverMaps
          .map((map) => Asset(
                symbol: map['symbol'] ?? '',
                name: map['name'] ?? '',
                turnover: (map['turnover'] ?? 0.0).toStringAsFixed(0) ?? "",
                ltp: (map['ltp'] ?? 0.0).toString(),
              ))
          .toList();

      List<Asset> topFourTurnover = fetchedTurnover.take(20).toList();

      return TurnoverData(topFourTurnover);
    } catch (error) {
      CustomToast.showToast("Turnover data error");
      rethrow;
    }
  }
}

class VolumeData {
  final List<Asset> volumeData;
  VolumeData(this.volumeData);

  static Future<VolumeData> getVolumeData() async {
    try {
      List<Map<String, dynamic>> fetchedVolumeMaps =
          await AssetService.getvolume();

      List<Asset> fetchedVolume = fetchedVolumeMaps
          .map((map) => Asset(
                symbol: map['symbol'] ?? '',
                name: map['name'] ?? '',
                turnover: (map['turnover'] ?? 0.0).toString(),
                ltp: (map['ltp'] ?? 0.0).toString(),
              ))
          .toList();

      List<Asset> topFourVolume = fetchedVolume.take(20).toList();

      return VolumeData(topFourVolume);
    } catch (error) {
      CustomToast.showToast("Volume data error");
      rethrow;
    }
  }
}

class CommodityData {
  final List<Asset> commodityData;
  CommodityData(this.commodityData);

  static Future<List<Asset>> getCommodityData() async {
    try {
      List<Map<String, dynamic>> fetchedTurnoverMaps =
          await AssetService.getcommodity();

      List<Asset> fetchedCommodities = fetchedTurnoverMaps
          .map((map) => Asset(
                symbol: map['name'] ?? '', //no symbol in commodity
                name: map['name'] ?? '',
                category: map['category'],
                unit: map['unit'],
                ltp: (map['ltp'] is int) ? map['ltp'].toString() : map['ltp'],
              ))
          .toList();

      fetchedCommodities.sort((a, b) => a.name.compareTo(b.name));

      //return CommodityData(fetchedCommodities);
      return fetchedCommodities;
    } catch (error) {
      CustomToast.showToast("Commodity data error");
      rethrow;
    }
  }
}

class MetalsData {
  final List<Asset> metalData;
  MetalsData(this.metalData);

  static Future<List<Asset>> getMetalsData() async {
    try {
      List<Map<String, dynamic>> fetchedTurnoverMaps =
          await AssetService.getMetal();

      List<Asset> fetchedCommodities = fetchedTurnoverMaps
          .map((map) => Asset(
                symbol: map['name'] ?? '', //no symbol in commodity
                name: map['name'] ?? '',
                sector: map['sector'] ?? '',
                category: map['category'],
                unit: map['unit'],
                ltp: (map['ltp'] is int) ? map['ltp'].toString() : map['ltp'],
              ))
          .toList();

      fetchedCommodities.sort((a, b) => a.name.compareTo(b.name));

      //return MetalsData(fetchedCommodities);
      return fetchedCommodities;
    } catch (error) {
      CustomToast.showToast("Metal data error");
      rethrow;
    }
  }
}

class TrendingData {
  final List<Asset> topFive;
  final List<Asset> bottomFive;
  TrendingData(this.topFive, this.bottomFive);

  static Future<TrendingData> getTrendingData() async {
    try {
      List<Map<String, dynamic>> fetchedTrendingMaps =
          await AssetService.gettrending();

      List<Asset> fetchedTrending = fetchedTrendingMaps
          .map((map) => Asset(
                symbol: map['symbol'] ?? '',
                name: map['name'] ?? '',
                percentchange: (map['percentageChange'] ?? 0).toString(),
                ltp: (map['ltp'] ?? 0.0).toString(),
              ))
          .toList();

      List<Asset> topFive = fetchedTrending.take(20).toList();

      List<Asset> bottomFive = fetchedTrending
          .skip(fetchedTrending.length - 10)
          .toList()
          .reversed
          .toList();

      return TrendingData(topFive, bottomFive);
    } catch (error) {
      CustomToast.showToast("Trending data error");
      rethrow;
    }
  }
}

class SingleAssetData {
  static Future<Asset> getSingleAssetData(String symbol) async {
    try {
      Map<String, dynamic> fetchedSymbolMap =
          await AssetService.getsingleasset(symbol);

      Asset singleAsset = Asset(
        symbol: fetchedSymbolMap['symbol'],
        name: fetchedSymbolMap['name'],
        category: fetchedSymbolMap['category'],
        sector: fetchedSymbolMap['sector'],
        eps: fetchedSymbolMap['eps'],
        bookvalue: fetchedSymbolMap['bookvalue'],
        pe: fetchedSymbolMap['pe'],
        ltp: fetchedSymbolMap['ltp'] is double
            ? fetchedSymbolMap['ltp'].toString()
            : fetchedSymbolMap['ltp'],
        percentchange: fetchedSymbolMap['percentchange'],
        totaltradedquantity: fetchedSymbolMap['totaltradedquantity'],
        previousclose: fetchedSymbolMap['previousclose'],
      );

      return singleAsset;
    } catch (error) {
      CustomToast.showToast("Single asset data error");
      rethrow;
    }
  }
}

class AssetData {
  static Future<List<Asset>> getAssetData() async {
    try {
      List<Map<String, dynamic>> fetchedSymbolMaps =
          await AssetService.getassets("allwithdata");

      List<Asset> fetchedSymbols = fetchedSymbolMaps
          .map((map) => Asset(
                symbol: map['symbol'],
                name: map['name'],
                category: map['category'],
                sector: map['sector'],
                eps: map['eps'],
                bookvalue: map['bookvalue'],
                pe: map['pe'],
                ltp: map['ltp'] is double ? map['ltp'].toString() : map['ltp'],
                percentchange: map['percentchange'],
                totaltradedquantity: map['totaltradedquantity'],
                previousclose: map['previousclose'],
              ))
          .toList();

      fetchedSymbols.sort((a, b) => a.name.compareTo(b.name));

      return fetchedSymbols;
    } catch (error) {
      CustomToast.showToast("asset data error");
      rethrow;
    }
  }
}

class MissingData {
  static Future<String> getMissingData(String symbol, String property) async {
    List<Asset> assetList = await AssetData.getAssetData();

    Asset? asset = assetList.firstWhere(
      (element) => element.symbol == symbol,
      orElse: () => Asset(symbol: symbol, name: 'Unknown'),
    );

    switch (property) {
      case 'name':
        List<String> words = asset.name.split(' ');
        return words.length > 2 ? words.sublist(0, 2).join(' ') : asset.name;
      case 'category':
        return asset.category ?? "No Category";
      case 'sector':
        return asset.sector ?? "No Sector";
      case 'eps':
        return asset.eps ?? "0.0";
      case 'bookvalue':
        return asset.bookvalue ?? "0.0";
      case 'pe':
        return asset.pe ?? "";
      case 'percentchange':
        return asset.percentchange ?? "0.0";
      case 'ltp':
        return asset.ltp ?? "0.0";
      case 'unit':
        return asset.unit ?? "0.0";
      case 'totaltradedquantity':
        return asset.totaltradedquantity ?? "0.0";
      case 'previousclose':
        return asset.previousclose ?? "0.0";
      case 'turnover':
        return asset.turnover ?? "0.0";
      default:
        return 'Unknown';
    }
  }
}
