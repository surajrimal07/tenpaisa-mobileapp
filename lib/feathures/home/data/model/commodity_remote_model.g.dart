// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityRemoteModel _$CommodityRemoteModelFromJson(
        Map<String, dynamic> json) =>
    CommodityRemoteModel(
      unit: json['unit'] as String,
      id: json['_id'] as String?,
      symbol: json['symbol'] as String?,
      name: json['name'] as String,
      category: json['category'] as String,
      ltp: (json['ltp'] as num).toDouble(),
    );

Map<String, dynamic> _$CommodityRemoteModelToJson(
        CommodityRemoteModel instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      '_id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'category': instance.category,
      'ltp': instance.ltp,
    };
