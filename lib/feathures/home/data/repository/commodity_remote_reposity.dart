import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/commodity_remote_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';
import 'package:paisa/feathures/home/domain/repository/commodity_repository.dart';

final commodityRemoteRepositoryProvider = Provider<ICommodityRepository>(
  (ref) => CommodityRemoteRepositoryImpl(
    commodityRemoteDataSource: ref.read(commodityRemoteDataProvider),
  ),
);

class CommodityRemoteRepositoryImpl implements ICommodityRepository {
  final CommodityRemoteDataSource commodityRemoteDataSource;

  CommodityRemoteRepositoryImpl({required this.commodityRemoteDataSource});

  @override
  Future<Either<Failure, List<CommodityEntity>>> getCommodity() {
    return commodityRemoteDataSource.getcommodity();
  }
}
