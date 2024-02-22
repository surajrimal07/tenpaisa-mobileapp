// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topturnover_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopTurnoverEntity _$TopTurnoverEntityFromJson(Map<String, dynamic> json) =>
    TopTurnoverEntity(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      turnover: (json['turnover'] as num).toDouble(),
    );

Map<String, dynamic> _$TopTurnoverEntityToJson(TopTurnoverEntity instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'turnover': instance.turnover,
      'ltp': instance.ltp,
    };
