import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/commodity_local_model.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';

final commodityCacheProvider = Provider<CommodityCache>((ref) {
  return CommodityCache(
      hiveService: ref.read(hiveServiceProvider),
      commodityLocalModel: ref.read(commodityLocalHiveModelProvider));
});

class CommodityCache {
  final HiveService hiveService;
  final CommodityLocalHiveModel commodityLocalModel;

  CommodityCache(
      {required this.hiveService, required this.commodityLocalModel});

  Future<void> addCommodityData(List<CommodityEntity> commodityData) async {
    await hiveService
        .addCommodity(commodityLocalModel.toHiveModelList(commodityData));
  }
}
