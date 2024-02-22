import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/categories_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';

final categoriesHiveDataSourceProvider = Provider<CategoriesHiveDataSource>(
  (ref) => CategoriesHiveDataSource(
      ref.read(hiveServiceProvider), ref.read(categoriesHiveModelProvider)),
);

class CategoriesHiveDataSource {
  final HiveService _hiveService;
  final CategoriesHiveModel _categoriesHiveModel;

  CategoriesHiveDataSource(this._hiveService, this._categoriesHiveModel);

  Future<void> addCategoriesData(TopCategoriesEntity categoriesData) async {
    await _hiveService
        .addCategoriesData(_categoriesHiveModel.toHiveModel(categoriesData));
  }

  Future<Either<Failure, TopCategoriesEntity>> getCategoriesData(
      bool refresh) async {
    try {
      CategoriesHiveModel? categoriesHiveModel =
          await _hiveService.getCategoriesData(refresh);

      if (categoriesHiveModel == null) {
        return Left(Failure(error: 'No Data Found'));
      } else {
        return Right(categoriesHiveModel.toEntity());
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
