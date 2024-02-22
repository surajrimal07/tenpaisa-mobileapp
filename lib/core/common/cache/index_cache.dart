import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/index_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';

final indexCacheProvider = Provider<IndexCache>((ref) {
  return IndexCache(
      hiveService: ref.read(hiveServiceProvider),
      indexHiveModel: ref.read(indexHiveModelProvider));
});

class IndexCache {
  final HiveService hiveService;
  final IndexHiveModel indexHiveModel;

  IndexCache({required this.hiveService, required this.indexHiveModel});

  Future<void> addIndexData(List<IndexEntity> indexData) async {
    await hiveService.addIndexData(indexHiveModel.toHiveModelList(indexData));
  }
}
