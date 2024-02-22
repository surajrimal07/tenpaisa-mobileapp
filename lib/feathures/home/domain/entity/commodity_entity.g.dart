// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityEntity _$CommodityEntityFromJson(Map<String, dynamic> json) =>
    CommodityEntity(
      unit: json['unit'] as String,
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      name: json['name'] as String,
      category: json['category'] as String,
      ltp: (json['ltp'] as num).toDouble(),
    );

Map<String, dynamic> _$CommodityEntityToJson(CommodityEntity instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'category': instance.category,
      'ltp': instance.ltp,
    };
