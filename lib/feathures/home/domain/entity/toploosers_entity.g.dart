// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toploosers_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopLoosersEntity _$TopLoosersEntityFromJson(Map<String, dynamic> json) =>
    TopLoosersEntity(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      pointchange: (json['pointchange'] as num).toDouble(),
      percentchange: (json['percentchange'] as num).toDouble(),
    );

Map<String, dynamic> _$TopLoosersEntityToJson(TopLoosersEntity instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'ltp': instance.ltp,
      'pointchange': instance.pointchange,
      'percentchange': instance.percentchange,
    };
