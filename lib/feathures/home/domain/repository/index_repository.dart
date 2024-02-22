import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/data/repository/index_local_repository.dart';
import 'package:paisa/feathures/home/data/repository/index_repository.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';

final indexProvider = Provider<IndexRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);
  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(indexRemoteRepositoryProvider)
      : ref.watch(indexLocalRepositoryProvider);
});

abstract class IndexRepository {
  Future<Either<Failure, List<IndexEntity>>> getIndex(bool refresh);
}
