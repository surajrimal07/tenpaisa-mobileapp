import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/data/repository/nrbdata_local_repository.dart';
import 'package:paisa/feathures/home/data/repository/nrbdata_remote_repository.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';

final nrbRepositoryProvider = Provider<NrbIRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);

  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(nrbRemoteRepositoryProvider)
      : ref.watch(nrbLocalRepositoryProvider);
});

abstract class NrbIRepository {
  Future<Either<Failure, NrbDataEntity>> getNrbData(bool refresh);
}
