import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/stock_hive_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/domain/repository/stock_repository.dart';

final stockLocalRepositoryProvider = Provider<IStockRepository>((ref) =>
    StockLocalRepository(hiveDataSource: ref.read(stockHiveDataSourceProvider)));

class StockLocalRepository implements IStockRepository {
  final StockHiveDataSource hiveDataSource;

  StockLocalRepository({required this.hiveDataSource});

  @override
  Future<Either<Failure, List<StockEntity>>> getStockList(bool refresh) async {
    return await hiveDataSource.getAllAsset(refresh);
  }
}
