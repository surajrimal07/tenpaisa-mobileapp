// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topvolume_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopVolumeEntity _$TopVolumeEntityFromJson(Map<String, dynamic> json) =>
    TopVolumeEntity(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      volume: json['volume'] as int,
    );

Map<String, dynamic> _$TopVolumeEntityToJson(TopVolumeEntity instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'volume': instance.volume,
      'ltp': instance.ltp,
    };
