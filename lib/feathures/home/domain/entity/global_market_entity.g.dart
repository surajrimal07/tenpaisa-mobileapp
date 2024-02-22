// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_market_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalMarketEntity _$GlobalMarketEntityFromJson(Map<String, dynamic> json) =>
    GlobalMarketEntity(
      index: json['index'] as String,
      quote: json['quote'] as num,
      change: json['change'] as num,
      changepercentage: json['changepercentage'] as num,
    );

Map<String, dynamic> _$GlobalMarketEntityToJson(GlobalMarketEntity instance) =>
    <String, dynamic>{
      'index': instance.index,
      'quote': instance.quote,
      'change': instance.change,
      'changepercentage': instance.changepercentage,
    };
