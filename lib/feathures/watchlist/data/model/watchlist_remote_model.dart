import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';

part 'watchlist_remote_model.g.dart';

final watchlistRemoteModelProvider = Provider<WatchlistRemoteModel>((ref) {
  return WatchlistRemoteModel(
    id: '',
    user: '',
    name: '',
    stocks: [],
  );
});

@JsonSerializable()
class WatchlistRemoteModel {
  @JsonKey(name: '_id')
  final String id;
  final String user;
  final String name;
  final List<String> stocks;

  WatchlistRemoteModel(
      {required this.id,
      required this.user,
      required this.name,
      required this.stocks});

  factory WatchlistRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$WatchlistRemoteModelFromJson(json);

  WatchlistEntity toEntity() => WatchlistEntity(
        id: id,
        user: user,
        name: name,
        stocks: stocks,
      );

  List<WatchlistEntity> toEntityList(
          List<WatchlistRemoteModel> remoteModelList) =>
      remoteModelList.map((e) => toEntityFromRemoteModel(e)).toList();

  WatchlistEntity toEntityFromRemoteModel(WatchlistRemoteModel remoteModel) =>
      WatchlistEntity(
        id: remoteModel.id,
        user: remoteModel.user,
        name: remoteModel.name,
        stocks: remoteModel.stocks,
      );
}
