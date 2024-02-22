import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/nrb_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/nrbdata_remote_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';

final nrbDataUseCaseProvider = Provider<NrbDataUseCase>((ref) => NrbDataUseCase(
    nrbRemoteDataSource: ref.read(nrbDataRemoteDataSourceProvider),
    nrbCache: ref.read(nrbCacheProvider)));

class NrbDataUseCase {
  final NrbRemoteDataSource nrbRemoteDataSource;
  final NrbCache nrbCache;

  NrbDataUseCase({required this.nrbRemoteDataSource, required this.nrbCache});

  Future<Either<Failure, NrbDataEntity>> getNrbData(bool refresh) async {
    final result = await nrbRemoteDataSource.getNrbData(refresh);

    return result.fold(
      (failure) => Left(failure),
      (nrbData) async {
        await nrbCache.addNrbData(nrbData);
        return Right(nrbData);
      },
    );

    // return nrbRemoteDataSource.getNrbData(refresh);
  }
}
