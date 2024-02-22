import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/stock_remote_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/domain/repository/stock_repository.dart';

final stockRemoteRepositoryProvider =
    Provider<IStockRepository>((ref) => StockRepositoryImpl(
          stockRemoteDataSource: ref.read(stockRemoteDataSourceProvider),
        ));

class StockRepositoryImpl implements IStockRepository {
  final StockRemoteDataSource stockRemoteDataSource;

  StockRepositoryImpl({required this.stockRemoteDataSource});

  @override
  Future<Either<Failure, List<StockEntity>>> getStockList(bool refresh) async {
    return await stockRemoteDataSource.getAllAsset(refresh);
  }
}
