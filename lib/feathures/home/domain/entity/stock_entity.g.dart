// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockEntity _$StockEntityFromJson(Map<String, dynamic> json) => StockEntity(
      symbol: json['symbol'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      pointChange: (json['pointChange'] as num).toDouble(),
      percentChange: (json['percentChange'] as num).toDouble(),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      volume: json['volume'] as int,
      previousClose: (json['previousClose'] as num).toDouble(),
      name: json['name'] as String,
      category: json['category'] as String,
      sector: json['sector'] as String,
      vwap: json['vwap'] as int?,
      turnover: json['turnover'] as int?,
      day120: json['day120'] as int?,
      day180: json['day180'] as int?,
      week52High: json['week52High'] as int?,
      week52Low: json['week52Low'] as int?,
    );

Map<String, dynamic> _$StockEntityToJson(StockEntity instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'ltp': instance.ltp,
      'pointChange': instance.pointChange,
      'percentChange': instance.percentChange,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'volume': instance.volume,
      'previousClose': instance.previousClose,
      'name': instance.name,
      'category': instance.category,
      'sector': instance.sector,
      'vwap': instance.vwap,
      'turnover': instance.turnover,
      'day120': instance.day120,
      'day180': instance.day180,
      'week52High': instance.week52High,
      'week52Low': instance.week52Low,
    };
