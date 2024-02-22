import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/world_data_local_datasource.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';
import 'package:paisa/feathures/home/domain/repository/world_market_repository.dart';

final worldMarketLocalRepositoryProvider = Provider<WorldMarketIRepository>(
  (ref) => WorldMarketLocalRepositoryImpl(
      localDataSource: ref.read(worldDataLocalDataSourceProvider)),
);

class WorldMarketLocalRepositoryImpl implements WorldMarketIRepository {
  final WorldDataLocalDataSource localDataSource;

  WorldMarketLocalRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, WorldMarketEntity>> getWorldMarket(
      bool refresh) async {
    return await localDataSource.getWorldMarket(refresh);
  }
}
