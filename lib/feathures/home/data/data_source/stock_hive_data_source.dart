import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/stocks_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';

final stockHiveDataSourceProvider = Provider<StockHiveDataSource>((ref) =>
    StockHiveDataSource(
        ref.read(hiveServiceProvider), ref.read(stockHiveModelProvider)));

class StockHiveDataSource {
  final HiveService _hiveService;
  final StocksHiveModel _stockHiveModel;

  StockHiveDataSource(this._hiveService, this._stockHiveModel);

  Future<Either<Failure, List<StockEntity>>> getAllAsset(bool refresh) async {
    try {
      List<StocksHiveModel> stock = await _hiveService.getStocksData(refresh);

      final stockList = _stockHiveModel.toEntityList(stock);
      return Right(stockList);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
