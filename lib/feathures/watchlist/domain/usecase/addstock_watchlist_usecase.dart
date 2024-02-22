import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/domain/repository/watchlist_repository.dart';

final addStockWatchlistUsecaseProvider = Provider<AddStockWatchlistUsecase>(
    (ref) => AddStockWatchlistUsecase(
        repository: ref.read(watchlistRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class AddStockWatchlistUsecase {
  final IWatchListRepository repository;
  final UserSharedPrefs userSharedPrefs;

  AddStockWatchlistUsecase(
      {required this.repository, required this.userSharedPrefs});

  Future<Either<Failure, List<WatchlistEntity>>> addStockWatchList(
      String id, String stock) async {
    final email = await userSharedPrefs.getUserEmail() ?? "";
    return await repository.addtoWatchList(email, id, stock);
  }
}
