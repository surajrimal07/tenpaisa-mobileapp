import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/data/repository/commodity_local_repository.dart';
import 'package:paisa/feathures/home/data/repository/commodity_remote_reposity.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';

final commodityProvider = Provider<ICommodityRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);

  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(commodityRemoteRepositoryProvider)
      : ref.watch(commodityLocalRepositoryProvider);
});

abstract class ICommodityRepository {
  Future<Either<Failure, List<CommodityEntity>>> getCommodity();
}
