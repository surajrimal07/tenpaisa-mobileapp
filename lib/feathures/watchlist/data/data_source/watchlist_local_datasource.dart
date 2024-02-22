import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/watchlist/data/model/watch_local_model.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';

final watchListLocalDataSourceProvider = Provider<WatchlistLocalDataSource>(
    (ref) => WatchlistLocalDataSource(
        ref.read(hiveServiceProvider), ref.read(watchListLocalModelProvider)));

class WatchlistLocalDataSource {
  final HiveService _hiveService;
  final WatchListLocalModel _watchlistRemoteModel;

  WatchlistLocalDataSource(this._hiveService, this._watchlistRemoteModel);

  Future<Either<Failure, List<WatchlistEntity>>> getWatchlist(
      String email) async {
    try {
      final watchlist = await _hiveService.getWatchlistData(email);
      List<WatchlistEntity> watchlistEntity =
          _watchlistRemoteModel.toEntityList(watchlist);
      return right(watchlistEntity);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<void> addWatchlistData(List<WatchlistEntity> watchlist) async {
    await _hiveService
        .addWatchlistData(_watchlistRemoteModel.toHiveModelList(watchlist));
  }

  Future<Either<Failure, List<WatchlistEntity>>> createWatchlist(
      String email, String name) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, List<WatchlistEntity>>> deleteWatchlist(
      String email, String id) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, List<WatchlistEntity>>> renameWatchlist(
      String email, String id, String name) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, List<WatchlistEntity>>> addtoWatchlist(
      String email, String id, String stock) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, List<WatchlistEntity>>> deletefromWatchlist(
      String email, String id, String stock) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }
}
