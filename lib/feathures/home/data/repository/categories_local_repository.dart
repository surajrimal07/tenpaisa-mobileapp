import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/categories_hive_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';
import 'package:paisa/feathures/home/domain/repository/categories_repository.dart';

final categoriesLocalRepositoryProvider = Provider<ICategoriesRepository>(
    (ref) => CategoriesLocalRepository(
        localDataSource: ref.read(categoriesHiveDataSourceProvider)));

class CategoriesLocalRepository implements ICategoriesRepository {
  final CategoriesHiveDataSource localDataSource;

  CategoriesLocalRepository({required this.localDataSource});
  @override
  Future<Either<Failure, TopCategoriesEntity>> getCategories(
      bool refresh) async {
    return await localDataSource.getCategoriesData(refresh);
  }
}
