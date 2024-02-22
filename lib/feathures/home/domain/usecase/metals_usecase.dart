import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/metals_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';
import 'package:paisa/feathures/home/domain/repository/metals_repository.dart';

final getMetalsUseCaseProvider = Provider<MetalsUseCase>((ref) => MetalsUseCase(
    metalrepository: ref.watch(metalsRepositoryProvider),
    metalCache: ref.watch(metalCacheProvider)));

class MetalsUseCase {
  final IMetalsRepository metalrepository;
  final MetalCache metalCache;

  MetalsUseCase({required this.metalrepository, required this.metalCache});

  Future<Either<Failure, List<MetalsEnity>>> getMetals() async {
    final result = await metalrepository.getMetals();
    return result.fold(
      (failure) => Left(failure),
      (metalList) async {
        await metalCache.addMetalData(metalList);
        return Right(metalList);
      },
    );
    //return await metalrepository.getMetals();
  }
}
