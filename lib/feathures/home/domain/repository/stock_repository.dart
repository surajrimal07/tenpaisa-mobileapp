import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/data/repository/stock_remote_repository.dart';
import 'package:paisa/feathures/home/data/repository/stocks_local_repository.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';

final stockProvider = Provider<IStockRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);

  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(stockRemoteRepositoryProvider)
      : ref.watch(stockLocalRepositoryProvider);
});

abstract class IStockRepository {
  Future<Either<Failure, List<StockEntity>>> getStockList(bool refresh);
}
