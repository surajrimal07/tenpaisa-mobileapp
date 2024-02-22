import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/domain/repository/watchlist_repository.dart';

final removeStockWatchlistUsecaseProvider = Provider<RemoveStockWatchlistUseCase>(
    (ref) => RemoveStockWatchlistUseCase(
        repository: ref.read(watchlistRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class RemoveStockWatchlistUseCase {
  final IWatchListRepository repository;
  final UserSharedPrefs userSharedPrefs;

  RemoveStockWatchlistUseCase(
      {required this.repository, required this.userSharedPrefs});

  Future<Either<Failure, List<WatchlistEntity>>> removeStockWatchList(
      String id, String stock) async {
    final email = await userSharedPrefs.getUserEmail() ?? "";
    return await repository.deletefromWatchList(email, id, stock);
  }
}
