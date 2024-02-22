import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/home/data/data_source/metals_remote_data_source.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';
import 'package:paisa/feathures/home/domain/repository/metals_repository.dart';

final metalsRemoteRepositoryProvider = Provider<IMetalsRepository>(
  (ref) => MetalsRemoteRepositoryImpl(
    metalremoteDataSource: ref.read(metalsRemoteProvider),
  ),
);

class MetalsRemoteRepositoryImpl implements IMetalsRepository {
  final MetalsRemoteDataSource metalremoteDataSource;

  MetalsRemoteRepositoryImpl({required this.metalremoteDataSource});

  @override
  Future<Either<Failure, List<MetalsEnity>>> getMetals() async {
    return metalremoteDataSource.getMetal();
  }
}
