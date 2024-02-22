import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/index_remote_datasource.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';
import 'package:paisa/feathures/home/domain/repository/index_repository.dart';

final indexRemoteRepositoryProvider = Provider<IndexRepository>(
  (ref) => IndexRemoteRepositoryImpl(
      indexRemoteDataSource: ref.read(indexRemoteDataSourceProvider)),
);

class IndexRemoteRepositoryImpl implements IndexRepository {
  final IndexRemoteDataSource indexRemoteDataSource;

  IndexRemoteRepositoryImpl({required this.indexRemoteDataSource});

  @override
  Future<Either<Failure, List<IndexEntity>>> getIndex(bool refresh) {
    return indexRemoteDataSource.getIndex(refresh);
  }
}
