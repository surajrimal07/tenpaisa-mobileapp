// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metals_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetalsEnity _$MetalsEnityFromJson(Map<String, dynamic> json) => MetalsEnity(
      unit: json['unit'] as String,
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      sector: json['sector'] as String,
      ltp: (json['ltp'] as num).toDouble(),
    );

Map<String, dynamic> _$MetalsEnityToJson(MetalsEnity instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'category': instance.category,
      'sector': instance.sector,
      'ltp': instance.ltp,
    };
