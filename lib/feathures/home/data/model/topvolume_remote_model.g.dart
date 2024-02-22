// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topvolume_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopVolumeRemoteModel _$TopVolumeRemoteModelFromJson(
        Map<String, dynamic> json) =>
    TopVolumeRemoteModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      volume: json['volume'] as int,
      ltp: (json['ltp'] as num).toDouble(),
    );

Map<String, dynamic> _$TopVolumeRemoteModelToJson(
        TopVolumeRemoteModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'volume': instance.volume,
      'ltp': instance.ltp,
    };
