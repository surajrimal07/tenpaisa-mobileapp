import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/domain/repository/watchlist_repository.dart';

final renameWatchlistUsecaseProvider = Provider<RenameWatchlistUsecase>((ref) =>
    RenameWatchlistUsecase(
        repository: ref.read(watchlistRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class RenameWatchlistUsecase {
  final IWatchListRepository repository;
  final UserSharedPrefs userSharedPrefs;

  RenameWatchlistUsecase(
      {required this.repository, required this.userSharedPrefs});

  Future<Either<Failure, List<WatchlistEntity>>> renameWatchList(
      String id, String name) async {
    final email = await userSharedPrefs.getUserEmail() ?? "";
    return await repository.renameWatchList(email, id, name);
  }
}
