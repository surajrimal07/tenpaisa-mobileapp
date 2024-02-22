import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/domain/repository/watchlist_repository.dart';

final deleteWatchlistUsecaseProvider = Provider<DeleteWatchlistUsecase>((ref) =>
    DeleteWatchlistUsecase(
        repository: ref.read(watchlistRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class DeleteWatchlistUsecase {
  final IWatchListRepository repository;
  final UserSharedPrefs userSharedPrefs;

  DeleteWatchlistUsecase(
      {required this.repository, required this.userSharedPrefs});

  Future<Either<Failure, List<WatchlistEntity>>> deleteWatchList(
      String id) async {
    final email = await userSharedPrefs.getUserEmail() ?? "";
    return await repository.deleteWatchList(email, id);
  }
}
