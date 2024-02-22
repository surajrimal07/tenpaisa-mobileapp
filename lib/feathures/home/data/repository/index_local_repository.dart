import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/index_hive_datasource.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';
import 'package:paisa/feathures/home/domain/repository/index_repository.dart';

final indexLocalRepositoryProvider = Provider<IndexRepository>((ref) =>
    IndexLocalRepository(
        hiveDataSource: ref.read(indexHiveDataSourceProvider)));

class IndexLocalRepository implements IndexRepository {
  final IndexHiveDataSource hiveDataSource;

  IndexLocalRepository({required this.hiveDataSource});

  @override
  Future<Either<Failure, List<IndexEntity>>> getIndex(bool refresh) async {
    return await hiveDataSource.getIndexData(refresh);
  }
}
