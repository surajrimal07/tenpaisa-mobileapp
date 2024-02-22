import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/world_data_remote_source.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';
import 'package:paisa/feathures/home/domain/repository/world_market_repository.dart';

final worldMarketRemoteRepositoryProvider = Provider<WorldMarketIRepository>(
  (ref) => WorldMarketRemoteRepositoryImpl(
      worldRemoteDataSource: ref.read(worldRemoteDataSource)),
);

class WorldMarketRemoteRepositoryImpl implements WorldMarketIRepository {
  final WorldRemoteDataSource worldRemoteDataSource;

  WorldMarketRemoteRepositoryImpl({required this.worldRemoteDataSource});

  @override
  Future<Either<Failure, WorldMarketEntity>> getWorldMarket(bool refresh) {
    return worldRemoteDataSource.getWorldData(refresh);
  }
}
