import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/watchlist_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/domain/repository/watchlist_repository.dart';

final getWatchlistUsecaseProvider = Provider<GetWatchlistUsecase>((ref) =>
    GetWatchlistUsecase(
        repository: ref.read(watchlistRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider),
        watchlistCache: ref.read(watchlistCacheProvider)));

class GetWatchlistUsecase {
  final IWatchListRepository repository;
  final UserSharedPrefs userSharedPrefs;
  final WatchlistCache watchlistCache;

  GetWatchlistUsecase(
      {required this.repository,
      required this.userSharedPrefs,
      required this.watchlistCache});

  Future<Either<Failure, List<WatchlistEntity>>> getWatchlist() async {
    final email = await userSharedPrefs.getUserEmail() ?? "";
    final result = await repository.getWatchList(email);
    return result.fold(
      (failure) => Left(failure),
      (watchList) async {
        await watchlistCache.addWatchListData(watchList);
        return Right(watchList);
      },
    );
    // return await repository.getWatchList(email);
  }
}
