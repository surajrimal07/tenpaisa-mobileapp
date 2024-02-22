import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/watchlist/data/model/watchlist_remote_model.dart';

part 'watchlist_remote_dto.g.dart';

@JsonSerializable()
class WatchlistDTO {
  final bool success;
  final String message;
  final List<WatchlistRemoteModel> data;

  WatchlistDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WatchlistDTO.fromJson(Map<String, dynamic> json) =>
      _$WatchlistDTOFromJson(json);
}
