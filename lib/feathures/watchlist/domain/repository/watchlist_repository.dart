import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/watchlist/data/repository/watchlis_local_repository.dart';
import 'package:paisa/feathures/watchlist/data/repository/watchlist_remote_repository.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';

final watchlistRepositoryProvider = Provider<IWatchListRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);

  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(watchlistRemoteRepositoryProvider)
      : ref.watch(watchlistLocalRepositoryProvider);
});

abstract class IWatchListRepository {
  Future<Either<Failure, List<WatchlistEntity>>> getWatchList(String email);
  Future<Either<Failure, List<WatchlistEntity>>> createWatchList(
      String email, String name);
  Future<Either<Failure, List<WatchlistEntity>>> deleteWatchList(
      String email, String id);
  Future<Either<Failure, List<WatchlistEntity>>> renameWatchList(
      String email, String id, String name);
  Future<Either<Failure, List<WatchlistEntity>>> addtoWatchList(
      String email, String id, String stock);
  Future<Either<Failure, List<WatchlistEntity>>> deletefromWatchList(
      String email, String id, String stock);
}
