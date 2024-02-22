import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/index_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';
import 'package:paisa/feathures/home/domain/repository/index_repository.dart';

final indexUseCaseProvider = Provider<IndexUseCase>((ref) {
  return IndexUseCase(
      indexRepository: ref.watch(indexProvider),
      indexCache: ref.read(indexCacheProvider));
});

class IndexUseCase {
  final IndexRepository indexRepository;
  final IndexCache indexCache;

  IndexUseCase({required this.indexRepository, required this.indexCache});

  Future<Either<Failure, List<IndexEntity>>> getIndex(bool refresh) async {
    final result = await indexRepository.getIndex(refresh);

    return result.fold(
      (failure) => Left(failure),
      (indexList) async {
        await indexCache.addIndexData(indexList);
        return Right(indexList);
      },
    );
    //return await indexRepository.getIndex(refresh);
  }
}
