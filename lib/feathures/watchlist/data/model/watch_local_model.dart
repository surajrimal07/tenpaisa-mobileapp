import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';

part 'watch_local_model.g.dart';

final watchListLocalModelProvider =
    Provider<WatchListLocalModel>((ref) => WatchListLocalModel.empty());

@HiveType(typeId: HiveTableConstant.watchlistTableId)
class WatchListLocalModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String user;
  @HiveField(2)
  String name;
  @HiveField(3)
  List<String> stocks;

  WatchListLocalModel({
    required this.id,
    required this.user,
    required this.name,
    required this.stocks,
  });

  WatchListLocalModel.empty()
      : id = '',
        user = '',
        name = '',
        stocks = [];

  WatchListLocalModel toHiveModel(WatchlistEntity model) {
    return WatchListLocalModel(
      id: model.id,
      user: model.user,
      name: model.name,
      stocks: model.stocks,
    );
  }

  WatchlistEntity toEntity() => WatchlistEntity(
        id: id,
        user: user,
        name: name,
        stocks: stocks,
      );

  WatchListLocalModel fromEntity(WatchlistEntity entity) {
    return WatchListLocalModel(
      id: entity.id,
      user: entity.user,
      name: entity.name,
      stocks: entity.stocks,
    );
  }

  List<WatchListLocalModel> toHiveModelList(List<WatchlistEntity> entityList) {
    return entityList.map((e) => fromEntity(e)).toList();
  }

  List<WatchlistEntity> toEntityList(List<WatchListLocalModel> hiveModelList) {
    return hiveModelList.map((e) => e.toEntity()).toList();
  }
}
