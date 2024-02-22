import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/stocks_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/domain/repository/stock_repository.dart';

final getStockUseCaseProvider = Provider<GetStockUseCase>((ref) =>
    GetStockUseCase(
        stockRepository: ref.read(stockProvider),
        stockCache: ref.read(stockCacheProvider)));

class GetStockUseCase {
  final IStockRepository stockRepository;
  final StockCache stockCache;

  GetStockUseCase({required this.stockRepository, required this.stockCache});

  Future<Either<Failure, List<StockEntity>>> getAllStocks(bool refresh) async {
    final result = await stockRepository.getStockList(refresh);

    return result.fold(
      (failure) => Left(failure),
      (stockList) async {
        await stockCache.addStockData(stockList);
        return Right(stockList);
      },
    );
    //return await stockRepository.getStockList(refresh);
  }
}
