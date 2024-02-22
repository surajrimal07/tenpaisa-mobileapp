import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/watchlist/data/data_source/watchlist_remote_data_source.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/domain/repository/watchlist_repository.dart';

final watchlistRemoteRepositoryProvider = Provider<IWatchListRepository>(
    (ref) => WatchlistRemoteRepositoryImpl(
          watchlistRemoteDataSource: ref.read(watchlistRemoteDataSourceProvider),
        ));

class WatchlistRemoteRepositoryImpl implements IWatchListRepository {
  final WatchlistRemoteDataSource watchlistRemoteDataSource;

  WatchlistRemoteRepositoryImpl({required this.watchlistRemoteDataSource});

  @override
  Future<Either<Failure, List<WatchlistEntity>>> getWatchList(String email) {
    return watchlistRemoteDataSource.getWatchlist(email);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> createWatchList(
      String email, String name) {
    return watchlistRemoteDataSource.createWatchlist(email, name);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> deleteWatchList(
      String email, String id) {
    return watchlistRemoteDataSource.deleteWatchlist(email, id);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> renameWatchList(
      String email, String id, String name) {
    return watchlistRemoteDataSource.renameWatchlist(email, id, name);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> addtoWatchList(
      String email, String id, String stock) {
    return watchlistRemoteDataSource.addStockToWatchlist(email, id, stock);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> deletefromWatchList(
      String email, String id, String stock) {
    return watchlistRemoteDataSource.removeStockFromWatchlist(email, id, stock);
  }
}
