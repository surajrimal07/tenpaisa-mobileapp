import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/metals_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';

final metalCacheProvider = Provider<MetalCache>((ref) {
  return MetalCache(
      hiveService: ref.read(hiveServiceProvider),
      metalsHiveModel: ref.read(metalsHiveModelProvider));
});

class MetalCache {
  final HiveService hiveService;
  final MetalsHiveModel metalsHiveModel;

  MetalCache({required this.hiveService, required this.metalsHiveModel});

  Future<void> addMetalData(List<MetalsEnity> metalData) async {
    await hiveService.addMetalsData(metalsHiveModel.toHiveModelList(metalData));
  }
}
