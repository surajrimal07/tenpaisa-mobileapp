import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/commodity_local_model.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';

final commodityLocalDataSourceProvider =
    Provider<CommodityLocalDataSource>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  final commodityHiveModel = ref.watch(commodityLocalHiveModelProvider);
  return CommodityLocalDataSource(hiveService, commodityHiveModel);
});

class CommodityLocalDataSource {
  final HiveService _hiveService;
  final CommodityLocalHiveModel _commodityHiveModel;

  CommodityLocalDataSource(this._hiveService, this._commodityHiveModel);

  Future<Either<Failure, List<CommodityEntity>>> getCommodityData() async {
    try {
      final commodity = await _hiveService.getcommodity();
      final commodityEntity = _commodityHiveModel.toEntityList(commodity);
      return Right(commodityEntity);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
