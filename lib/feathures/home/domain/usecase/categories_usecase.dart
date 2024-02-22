import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/categories_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';
import 'package:paisa/feathures/home/domain/repository/categories_repository.dart';

final categoriesUseCaseProvider = Provider<CategoriesUseCase>((ref) =>
    CategoriesUseCase(
        categoriesRepository: ref.watch(topCategoriesProvider),
        categoriesCache: ref.watch(categoriesCacheProvider)));

class CategoriesUseCase {
  final ICategoriesRepository categoriesRepository;
  final CategoriesCache categoriesCache;

  CategoriesUseCase(
      {required this.categoriesRepository, required this.categoriesCache});

  Future<Either<Failure, TopCategoriesEntity>> getCategories(
      bool refresh) async {
    final result = await categoriesRepository.getCategories(refresh);
    return result.fold(
      (failure) => Left(failure),
      (categories) async {
        await categoriesCache.addCategoriesData(categories);
        return Right(categories);
      },
    );
    // return await categoriesRepository.getCategories(refresh);
  }
}
