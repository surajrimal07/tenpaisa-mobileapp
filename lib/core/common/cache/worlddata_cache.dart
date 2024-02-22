import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/world_market_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';

final worldDataCacheProvider = Provider<WorldDataCache>((ref) {
  return WorldDataCache(
      hiveService: ref.read(hiveServiceProvider),
      worldDataLocalModel: ref.read(worldMarkethiveModelPRovider));
});

class WorldDataCache {
  final HiveService hiveService;
  final WorldMarketHiveModel worldDataLocalModel;

  WorldDataCache(
      {required this.hiveService, required this.worldDataLocalModel});

  Future<void> addWorldData(WorldMarketEntity worldMarketEntity) async {
    await hiveService
        .addWorldMarketData(worldDataLocalModel.toHiveModel(worldMarketEntity));
  }
}
