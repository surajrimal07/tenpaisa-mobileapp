import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/metals_hive_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';
import 'package:paisa/feathures/home/domain/repository/metals_repository.dart';

final metalsLocalRepositoryProvider = Provider<IMetalsRepository>((ref) =>
    MetalsLocalRepository(metalDataSource: ref.read(metalsHiveDataSourceProvider)));

class MetalsLocalRepository implements IMetalsRepository {
  final MetalsHiveDataSource metalDataSource;

  MetalsLocalRepository({required this.metalDataSource});

  @override
  Future<Either<Failure, List<MetalsEnity>>> getMetals() async {
    return await metalDataSource.getMetals();
  }
}
