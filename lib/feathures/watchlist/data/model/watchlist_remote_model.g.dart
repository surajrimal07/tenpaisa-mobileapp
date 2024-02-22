// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchlistRemoteModel _$WatchlistRemoteModelFromJson(
        Map<String, dynamic> json) =>
    WatchlistRemoteModel(
      id: json['_id'] as String,
      user: json['user'] as String,
      name: json['name'] as String,
      stocks:
          (json['stocks'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WatchlistRemoteModelToJson(
        WatchlistRemoteModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'name': instance.name,
      'stocks': instance.stocks,
    };
