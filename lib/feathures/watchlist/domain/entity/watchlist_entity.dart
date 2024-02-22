import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'watchlist_entity.g.dart';

@JsonSerializable()
class WatchlistEntity extends Equatable {
  final String id;
  final String user;
  final String name;
  final List<String> stocks;

  const WatchlistEntity({
    required this.id,
    required this.user,
    required this.name,
    required this.stocks,
  });

  @override
  List<Object?> get props => [id, user, name, stocks];

  factory WatchlistEntity.fromJson(Map<String, dynamic> json) =>
      _$WatchlistEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WatchlistEntityToJson(this);

  WatchlistEntity toEntity() => WatchlistEntity(
        id: id,
        user: user,
        name: name,
        stocks: stocks,
      );
}
