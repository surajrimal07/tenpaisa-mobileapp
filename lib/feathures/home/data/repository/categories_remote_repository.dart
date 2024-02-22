import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/categories_remote_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';
import 'package:paisa/feathures/home/domain/repository/categories_repository.dart';

final categoriesRemoteRepositoryProvider = Provider<ICategoriesRepository>(
  (ref) => CategoriesRemoteRepositoryImpl(
    categoriesRemoteDataSource: ref.read(topCategoriesRemoteProvider),
  ),
);

class CategoriesRemoteRepositoryImpl implements ICategoriesRepository {
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRemoteRepositoryImpl({required this.categoriesRemoteDataSource});

  @override
  Future<Either<Failure, TopCategoriesEntity>> getCategories(bool refresh) {
    return categoriesRemoteDataSource.getAllCategories(refresh);
  }
}
