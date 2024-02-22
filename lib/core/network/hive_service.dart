import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/auth/data/model/auth_hive_model.dart';
import 'package:paisa/feathures/home/data/model/categories_hive_model.dart';
import 'package:paisa/feathures/home/data/model/commodity_local_model.dart';
import 'package:paisa/feathures/home/data/model/cryptocurrency_hive_model.dart';
import 'package:paisa/feathures/home/data/model/currencyfx_hive_model.dart';
import 'package:paisa/feathures/home/data/model/globalmarket_hive_model.dart';
import 'package:paisa/feathures/home/data/model/index_hive_model.dart';
import 'package:paisa/feathures/home/data/model/metals_hive_model.dart';
import 'package:paisa/feathures/home/data/model/nrb_banking_local_model.dart';
import 'package:paisa/feathures/home/data/model/nrb_currency_local_model.dart';
import 'package:paisa/feathures/home/data/model/nrb_data_local_model.dart';
import 'package:paisa/feathures/home/data/model/nrb_forex_local_data.dart';
import 'package:paisa/feathures/home/data/model/stocks_hive_model.dart';
import 'package:paisa/feathures/home/data/model/topgainers_hive_model.dart';
import 'package:paisa/feathures/home/data/model/toploosers_hive_model.dart';
import 'package:paisa/feathures/home/data/model/toptransaction_hive_model.dart';
import 'package:paisa/feathures/home/data/model/topturnover_hive_model.dart';
import 'package:paisa/feathures/home/data/model/topvolume_hive_model.dart';
import 'package:paisa/feathures/home/data/model/world_market_hive_model.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_combined_local_model.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_data_local_model.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_hive_model.dart';
import 'package:paisa/feathures/watchlist/data/model/watch_local_model.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

class HiveService {
  Future<void> init() async {
    var path = await getDatabasePath();
    Hive.init(path);

    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(WorldMarketHiveModelAdapter());
    Hive.registerAdapter(CategoriesHiveModelAdapter());
    Hive.registerAdapter(TopGainersHiveModelAdapter());
    Hive.registerAdapter(TopLoosersHiveModelAdapter());
    Hive.registerAdapter(TopTransactionHiveModelAdapter());
    Hive.registerAdapter(TopTurnoverHiveModelAdapter());
    Hive.registerAdapter(TopVolumeHiveModelAdapter());

    Hive.registerAdapter(StocksHiveModelAdapter());
    Hive.registerAdapter(IndexHiveModelAdapter());
    Hive.registerAdapter(MetalsHiveModelAdapter());
    Hive.registerAdapter(CommodityLocalHiveModelAdapter());
    Hive.registerAdapter(WatchListLocalModelAdapter());
    Hive.registerAdapter(NrbDataLocalHiveModelAdapter());

    Hive.registerAdapter(NrbBankingLocalModelAdapter());
    Hive.registerAdapter(NrbForexLocalModelAdapter());
    Hive.registerAdapter(CurrencyLocalModelAdapter());

    Hive.registerAdapter(CryptoCurrencyHiveModelAdapter());
    Hive.registerAdapter(CurrencyfxHiveModelAdapter());
    Hive.registerAdapter(GlobalMarketHiveModelAdapter());

    Hive.registerAdapter(PortfolioLocalCombinedModelAdapter());
    Hive.registerAdapter(PortfolioDataHiveModelAdapter());
    Hive.registerAdapter(PortfolioHiveModelAdapter());
  }

  Future<String> getDatabasePath() async {
    if (kIsWeb) {
      return "/assets/db";
    } else {
      var appDocDir = await getApplicationDocumentsDirectory();
      return appDocDir.path;
    }
  }

  // ======================== User Data ========================

  //save user to cache

  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.email, user);
    box.close();
  }

  Future<AuthHiveModel> loginUser(
      String email, String password, bool remember) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return user;
  }

  Future<AuthHiveModel> getUser(String email) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
      (user) => user.email == email,
    );
    box.close();
    return user;
  }

  // ======================== World Market Data ========================

  Future<void> addWorldMarketData(WorldMarketHiveModel worlddata) async {
    var box = await Hive.openBox<WorldMarketHiveModel>(
        HiveTableConstant.worldMarketBox);
    await box.put(worlddata.worldMarketId, worlddata);
    print("World Market Data Cached");
    box.close();
  }

  Future<WorldMarketHiveModel> getWorldMarketData() async {
    var box = await Hive.openBox<WorldMarketHiveModel>(
        HiveTableConstant.worldMarketBox);
    var worldData = box.values.first;
    box.close();
    return worldData;
  }

  // ======================== Categories All Data ========================

  Future<void> addCategoriesData(CategoriesHiveModel categoriesData) async {
    var box = await Hive.openBox<CategoriesHiveModel>(
        HiveTableConstant.categoriesBox);
    await box.put(categoriesData.categoriesId, categoriesData);
    print("Categories Data Cached");
    box.close();
  }

  Future<CategoriesHiveModel?> getCategoriesData(bool refresh) async {
    var box = await Hive.openBox<CategoriesHiveModel>(
        HiveTableConstant.categoriesBox);
    var categoriesData = box.values.first;
    box.close();
    return categoriesData;
  }

  // ======================== Stocks All Data ========================
  Future<void> addStocksData(List<StocksHiveModel> stockData) async {
    var box =
        await Hive.openBox<List<StocksHiveModel>>(HiveTableConstant.stocksBox);
    await box.put(HiveTableConstant.stocksTableId, stockData);
    print("Stocks Data Cached");
    box.close();
  }

  Future<List<StocksHiveModel>> getStocksData(bool refresh) async {
    var box = await Hive.openBox<StocksHiveModel>(HiveTableConstant.stocksBox);
    var stockData = box.values.toList();
    box.close();
    return stockData;
  }
  // ======================== Index All Data ========================

  Future<void> addIndexData(List<IndexHiveModel> indexData) async {
    var box =
        await Hive.openBox<List<IndexHiveModel>>(HiveTableConstant.indexBox);
    await box.put(HiveTableConstant.indexTableId, indexData);
    print("Index Data Cached");
    box.close();
  }

  Future<List<IndexHiveModel>> getIndexData(bool refresh) async {
    var box = await Hive.openBox<IndexHiveModel>(HiveTableConstant.indexBox);
    var indexData = box.values.toList();
    box.close();
    print("index data from cache is $indexData");
    return indexData;
  }

  // ======================== Metals All Data ========================

  Future<void> addMetalsData(List<MetalsHiveModel> metalsData) async {
    var box =
        await Hive.openBox<List<MetalsHiveModel>>(HiveTableConstant.metalBox);
    await box.put(HiveTableConstant.metalTableId, metalsData);
    box.close();
  }

  Future<List<MetalsHiveModel>> getMetalsData() async {
    var box = await Hive.openBox<MetalsHiveModel>(HiveTableConstant.metalBox);
    var metalsData = box.values.toList();
    box.close();
    return metalsData;
  }

  // ======================== Commodity All Data ========================

  Future<void> addCommodity(List<CommodityLocalHiveModel> commodityData) async {
    var box = await Hive.openBox<List<CommodityLocalHiveModel>>(
        HiveTableConstant.commodityBox);
    print("Commodity Data Cached");
    await box.put(HiveTableConstant.commodityTableId, commodityData);
    box.close();
  }

  Future<List<CommodityLocalHiveModel>> getcommodity() async {
    var box = await Hive.openBox<CommodityLocalHiveModel>(
        HiveTableConstant.commodityBox);
    var commodityData = box.values.toList();
    box.close();
    return commodityData;
  }

  // ======================== Watchlist All Data ========================

  Future<void> addWatchlistData(List<WatchListLocalModel> watchlist) async {
    var box = await Hive.openBox<List<WatchListLocalModel>>(
        HiveTableConstant.wathistbox);
    await box.put(HiveTableConstant.watchlistTableId, watchlist);
    print("Watchlist Data Cached");
    box.close();
  }

  Future<List<WatchListLocalModel>> getWatchlistData(String email) async {
    var box =
        await Hive.openBox<WatchListLocalModel>(HiveTableConstant.wathistbox);
    var watchlist =
        box.values.where((element) => element.user == email).toList();
    box.close();
    return watchlist;
  }

  // ======================== NrbData Market Data ========================

  Future<void> addNrbDataMarketData(NrbDataLocalHiveModel nrbdata) async {
    var box =
        await Hive.openBox<NrbDataLocalHiveModel>(HiveTableConstant.nrbbox);
    await box.put(HiveTableConstant.nrbboxId, nrbdata);
    print("Nrb Data Cached");
    box.close();
  }

  Future<NrbDataLocalHiveModel> getNrbDataMarketData() async {
    var box =
        await Hive.openBox<NrbDataLocalHiveModel>(HiveTableConstant.nrbbox);
    var nrbData = box.values.first;
    box.close();
    return nrbData;
  }

  // ======================== Portfolio Data ========================

  Future<void> addPortfolioData(PortfolioLocalCombinedModel portfolio) async {
    var box = await Hive.openBox<PortfolioLocalCombinedModel>(
        HiveTableConstant.portfolioBox);
    await box.put(HiveTableConstant.portfolioTableId, portfolio);
    print("Portfolio Data Cached");
    box.close();
  }

  Future<PortfolioLocalCombinedModel> getPortfolioData() async {
    var box = await Hive.openBox<PortfolioLocalCombinedModel>(
        HiveTableConstant.portfolioBox);
    var portfolio = box.values.first;
    box.close();
    return portfolio;
  }

  // ======================== Delete All Data ========================
  Future<void> deleteAllData() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.clear();
  }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteFromDisk();
  }
}
