import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/worlddata_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/world_data_remote_source.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';

final worldMarketUseCaseProvider = Provider<WorldMarketUseCase>((ref) =>
    WorldMarketUseCase(
        worldRemoteDataSource: ref.read(worldRemoteDataSource),
        worldDataCache: ref.read(worldDataCacheProvider)));

class WorldMarketUseCase {
  final WorldRemoteDataSource worldRemoteDataSource;
  final WorldDataCache worldDataCache;

  WorldMarketUseCase(
      {required this.worldRemoteDataSource, required this.worldDataCache});

  Future<Either<Failure, WorldMarketEntity>> getWorldMarket(
      bool refresh) async {
    final result = await worldRemoteDataSource.getWorldData(refresh);
    return result.fold(
      (failure) => Left(failure),
      (worldMarket) async {
        await worldDataCache.addWorldData(worldMarket);
        return Right(worldMarket);
      },
    );
    //return worldRemoteDataSource.getWorldData(refresh);
  }
}
