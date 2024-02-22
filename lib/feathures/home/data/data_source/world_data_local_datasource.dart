import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/world_market_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';

final worldDataLocalDataSourceProvider = Provider<WorldDataLocalDataSource>(
  (ref) => WorldDataLocalDataSource(
      ref.read(hiveServiceProvider), ref.read(worldMarkethiveModelPRovider)),
);

class WorldDataLocalDataSource {
  final HiveService _hiveService;
  final WorldMarketHiveModel worldMarketHiveModel;

  WorldDataLocalDataSource(this._hiveService, this.worldMarketHiveModel);

  Future<Either<Failure, WorldMarketEntity>> getWorldMarket(
      bool refresh) async {
    try {
      final worldMarketHiveModel = await _hiveService.getWorldMarketData();
      final worldMarketEntity = worldMarketHiveModel.toEntity();
      return Right(worldMarketEntity);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
