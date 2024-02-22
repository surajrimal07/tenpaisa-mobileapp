import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/nrb_data_local_model.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';

final nrbLocalDataSource = Provider<NrbDataHiveDataSource>((ref) =>
    NrbDataHiveDataSource(
        hiveService: ref.read(hiveServiceProvider),
        nrbDataLocalHiveModel: ref.read(nrbDataLocalHiveModelProvider)));

class NrbDataHiveDataSource {
  final HiveService hiveService;
  final NrbDataLocalHiveModel nrbDataLocalHiveModel;

  NrbDataHiveDataSource(
      {required this.hiveService, required this.nrbDataLocalHiveModel});

  Future<Either<Failure, NrbDataEntity>> getNrbDataMarketData() async {
    try {
      NrbDataLocalHiveModel nrb = await hiveService.getNrbDataMarketData();
      final nrbData = nrb.toEntity();
      return Right(nrbData);
    } catch (e) {
      rethrow;
    }
  }
}
