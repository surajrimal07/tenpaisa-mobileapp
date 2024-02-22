import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/stocks_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';

final stockCacheProvider = Provider<StockCache>((ref) {
  return StockCache(
      hiveService: ref.read(hiveServiceProvider),
      stocksHiveModel: ref.read(stockHiveModelProvider));
});

class StockCache {
  final HiveService hiveService;
  final StocksHiveModel stocksHiveModel;

  StockCache({required this.hiveService, required this.stocksHiveModel});

  Future<void> addStockData(List<StockEntity> stockData) async {
    await hiveService.addStocksData(stocksHiveModel.toHiveModelList(stockData));
  }
}
