import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/watchlist/data/data_source/watchlist_local_datasource.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/domain/repository/watchlist_repository.dart';

final watchlistLocalRepositoryProvider = Provider<IWatchListRepository>((ref) =>
    WatchlistLocalRepository(
        hiveDataSource: ref.read(watchListLocalDataSourceProvider)));

class WatchlistLocalRepository implements IWatchListRepository {
  final WatchlistLocalDataSource hiveDataSource;

  WatchlistLocalRepository({required this.hiveDataSource});

  @override
  Future<Either<Failure, List<WatchlistEntity>>> getWatchList(
      String email) async {
    return await hiveDataSource.getWatchlist(email);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> addtoWatchList(
      String email, String id, String stock) {
    return hiveDataSource.addtoWatchlist(email, id, stock);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> createWatchList(
      String email, String name) {
    return hiveDataSource.createWatchlist(email, name);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> deleteWatchList(
      String email, String id) {
    return hiveDataSource.deleteWatchlist(email, id);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> deletefromWatchList(
      String email, String id, String stock) {
    return hiveDataSource.deletefromWatchlist(email, id, stock);
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> renameWatchList(
      String email, String id, String name) {
    return hiveDataSource.renameWatchlist(email, id, name);
  }
}
