import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/metals_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';

final metalsHiveDataSourceProvider = Provider<MetalsHiveDataSource>((ref) {
  return MetalsHiveDataSource(
    hiveService: ref.read(hiveServiceProvider),
    metalsHiveModel: ref.read(metalsHiveModelProvider),
  );
});

class MetalsHiveDataSource {
  final HiveService hiveService;
  final MetalsHiveModel metalsHiveModel;

  MetalsHiveDataSource(
      {required this.hiveService, required this.metalsHiveModel});

  Future<Either<Failure, List<MetalsEnity>>> getMetals() async {
    try {
      final metals = await hiveService.getMetalsData();
      final metalEntity = metalsHiveModel.toEntityList(metals);
      return Right(metalEntity);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
