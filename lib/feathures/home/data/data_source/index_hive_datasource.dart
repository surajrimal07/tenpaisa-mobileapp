import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/home/data/model/index_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';

final indexHiveDataSourceProvider = Provider<IndexHiveDataSource>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  final indexHiveModel = ref.watch(indexHiveModelProvider);
  return IndexHiveDataSource(hiveService, indexHiveModel);
});

class IndexHiveDataSource {
  final HiveService _hiveService;
  final IndexHiveModel _indexHiveModel;

  IndexHiveDataSource(this._hiveService, this._indexHiveModel);

  Future<Either<Failure, List<IndexEntity>>> getIndexData(bool refresh) async {
    try {
      final index = await _hiveService.getIndexData(refresh);
      final indexEntity = _indexHiveModel.toEntityList(index);
      return Right(indexEntity);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
