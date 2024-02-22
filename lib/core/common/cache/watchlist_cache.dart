import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/watchlist/data/model/watch_local_model.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';

final watchlistCacheProvider = Provider<WatchlistCache>((ref) {
  return WatchlistCache(
      hiveService: ref.read(hiveServiceProvider),
      watchListLocalModel: ref.read(watchListLocalModelProvider));
});

class WatchlistCache {
  final HiveService hiveService;
  final WatchListLocalModel watchListLocalModel;

  WatchlistCache(
      {required this.hiveService, required this.watchListLocalModel});

  Future<void> addWatchListData(List<WatchlistEntity> watchListEntity) async {
    await hiveService
        .addWatchlistData(watchListLocalModel.toHiveModelList(watchListEntity));
  }
}
