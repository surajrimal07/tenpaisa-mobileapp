import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/commodity_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';
import 'package:paisa/feathures/home/domain/repository/commodity_repository.dart';

final getCommodityUseCaseProvider = Provider<CommodityUseCase>((ref) =>
    CommodityUseCase(
        commodityRepository: ref.watch(commodityProvider),
        commodityCache: ref.watch(commodityCacheProvider)));

class CommodityUseCase {
  final ICommodityRepository commodityRepository;
  final CommodityCache commodityCache;

  CommodityUseCase(
      {required this.commodityRepository, required this.commodityCache});

  Future<Either<Failure, List<CommodityEntity>>> getCommodity() async {
    final result = await commodityRepository.getCommodity();
    return result.fold(
      (failure) => Left(failure),
      (commodityList) async {
        await commodityCache.addCommodityData(commodityList);
        return Right(commodityList);
      },
    );
    //return await commodityRepository.getCommodity();
  }
}
