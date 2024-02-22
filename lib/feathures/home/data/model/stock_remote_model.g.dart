// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRemoteModel _$StockRemoteModelFromJson(Map<String, dynamic> json) =>
    StockRemoteModel(
      symbol: json['symbol'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      pointchange: (json['pointchange'] as num).toDouble(),
      percentchange: (json['percentchange'] as num).toDouble(),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      volume: json['volume'] as int,
      previousclose: (json['previousclose'] as num).toDouble(),
      name: json['name'] as String,
      category: json['category'] as String,
      sector: json['sector'] as String,
      vwap: json['vwap'] as int?,
      turnover: json['Turnover'] as int?,
      day120: json['day120'] as int?,
      day180: json['day180'] as int?,
      week52high: json['week52high'] as int?,
      week52low: json['week52low'] as int?,
    );

Map<String, dynamic> _$StockRemoteModelToJson(StockRemoteModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'ltp': instance.ltp,
      'pointchange': instance.pointchange,
      'percentchange': instance.percentchange,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'volume': instance.volume,
      'previousclose': instance.previousclose,
      'name': instance.name,
      'category': instance.category,
      'sector': instance.sector,
      'vwap': instance.vwap,
      'Turnover': instance.turnover,
      'day120': instance.day120,
      'day180': instance.day180,
      'week52high': instance.week52high,
      'week52low': instance.week52low,
    };
