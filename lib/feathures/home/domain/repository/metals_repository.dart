import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/data/repository/metals_local_repository.dart';
import 'package:paisa/feathures/home/data/repository/metals_remote_repository.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';

final metalsRepositoryProvider = Provider<IMetalsRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);
  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(metalsRemoteRepositoryProvider)
      : ref.watch(metalsLocalRepositoryProvider);
});

abstract class IMetalsRepository {
  Future<Either<Failure, List<MetalsEnity>>> getMetals();
}
