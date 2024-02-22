// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topgaines_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopGainersEntity _$TopGainersEntityFromJson(Map<String, dynamic> json) =>
    TopGainersEntity(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      pointchange: (json['pointchange'] as num).toDouble(),
      percentchange: (json['percentchange'] as num).toDouble(),
    );

Map<String, dynamic> _$TopGainersEntityToJson(TopGainersEntity instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'ltp': instance.ltp,
      'pointchange': instance.pointchange,
      'percentchange': instance.percentchange,
    };
