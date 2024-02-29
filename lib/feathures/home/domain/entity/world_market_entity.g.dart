// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'world_market_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldMarketEntity _$WorldMarketEntityFromJson(Map<String, dynamic> json) =>
    WorldMarketEntity(
      cryptocurrency: (json['cryptocurrency'] as List<dynamic>)
          .map((e) => CryptoEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      forex: (json['forex'] as List<dynamic>)
          .map((e) => CurrencyFxEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      asianmarket: (json['asianmarket'] as List<dynamic>)
          .map((e) => GlobalMarketEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      europeanMarket: (json['europeanMarket'] as List<dynamic>)
          .map((e) => GlobalMarketEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      americanmarket: (json['americanmarket'] as List<dynamic>)
          .map((e) => GlobalMarketEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorldMarketEntityToJson(WorldMarketEntity instance) =>
    <String, dynamic>{
      'cryptocurrency': instance.cryptocurrency,
      'forex': instance.forex,
      'asianmarket': instance.asianmarket,
      'europeanMarket': instance.europeanMarket,
      'americanmarket': instance.americanmarket,
    };
