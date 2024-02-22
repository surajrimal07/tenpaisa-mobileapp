import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/nrbdata_hive_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';
import 'package:paisa/feathures/home/domain/repository/nrb_irepository.dart';

final nrbLocalRepositoryProvider = Provider<NrbIRepository>(
  (ref) =>
      NrbDataLocalRepository(localDataSource: ref.read(nrbLocalDataSource)),
);

class NrbDataLocalRepository implements NrbIRepository {
  final NrbDataHiveDataSource localDataSource;

  NrbDataLocalRepository({required this.localDataSource});

  @override
  Future<Either<Failure, NrbDataEntity>> getNrbData(bool refresh) async {
    return await localDataSource.getNrbDataMarketData();
  }
}
