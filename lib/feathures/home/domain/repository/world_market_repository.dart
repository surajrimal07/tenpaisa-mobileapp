import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/data/repository/world_market_local_repository.dart';
import 'package:paisa/feathures/home/data/repository/world_market_remote_repository.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';

final worldMarketRepositoryProvider = Provider<WorldMarketIRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);

  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(worldMarketRemoteRepositoryProvider)
      : ref.watch(worldMarketLocalRepositoryProvider);
});

abstract class WorldMarketIRepository {
  Future<Either<Failure, WorldMarketEntity>> getWorldMarket(bool refresh);
}
