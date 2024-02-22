import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/data/repository/categories_local_repository.dart';
import 'package:paisa/feathures/home/data/repository/categories_remote_repository.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';

final topCategoriesProvider = Provider<ICategoriesRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);

  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(categoriesRemoteRepositoryProvider)
      : ref.watch(categoriesLocalRepositoryProvider);
});

abstract class ICategoriesRepository {
  Future<Either<Failure, TopCategoriesEntity>> getCategories(bool refresh);
}
