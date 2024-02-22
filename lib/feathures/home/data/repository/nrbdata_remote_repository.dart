import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/nrbdata_remote_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';
import 'package:paisa/feathures/home/domain/repository/nrb_irepository.dart';

final nrbRemoteRepositoryProvider = Provider<NrbIRepository>(
  (ref) => NrbDataRemoteRepositoryImpl(
      remoteDataSource: ref.read(nrbDataRemoteDataSourceProvider)),
);

class NrbDataRemoteRepositoryImpl implements NrbIRepository {
  final NrbRemoteDataSource remoteDataSource;

  NrbDataRemoteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, NrbDataEntity>> getNrbData(bool refresh) async {
    return remoteDataSource.getNrbData(refresh);
  }
}
