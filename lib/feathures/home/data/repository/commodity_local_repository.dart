



import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/commodity_hive_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';
import 'package:paisa/feathures/home/domain/repository/commodity_repository.dart';

final commodityLocalRepositoryProvider = Provider<ICommodityRepository>(
    (ref) => CommodityLocalRepository(
        hiveDataSource: ref.read(commodityLocalDataSourceProvider)));

class CommodityLocalRepository implements ICommodityRepository {
  final CommodityLocalDataSource hiveDataSource;

  CommodityLocalRepository({required this.hiveDataSource});

  @override
  Future<Either<Failure, List<CommodityEntity>>> getCommodity() async {
    return await hiveDataSource.getCommodityData();
  }
}