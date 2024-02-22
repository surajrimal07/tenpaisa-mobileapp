// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchlistEntity _$WatchlistEntityFromJson(Map<String, dynamic> json) =>
    WatchlistEntity(
      id: json['id'] as String,
      user: json['user'] as String,
      name: json['name'] as String,
      stocks:
          (json['stocks'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WatchlistEntityToJson(WatchlistEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'name': instance.name,
      'stocks': instance.stocks,
    };
