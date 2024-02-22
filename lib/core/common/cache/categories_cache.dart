import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/categories_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';

final categoriesCacheProvider = Provider<CategoriesCache>((ref) {
  return CategoriesCache(
      hiveService: ref.read(hiveServiceProvider),
      categoriesHiveModel: ref.read(categoriesHiveModelProvider));
});

class CategoriesCache {
  final HiveService hiveService;
  final CategoriesHiveModel categoriesHiveModel;

  CategoriesCache(
      {required this.hiveService, required this.categoriesHiveModel});

  Future<void> addCategoriesData(TopCategoriesEntity categoriesData) async {
    await hiveService
        .addCategoriesData(categoriesHiveModel.toHiveModel(categoriesData));
  }
}
