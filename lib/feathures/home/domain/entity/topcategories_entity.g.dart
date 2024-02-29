// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'topcategories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopCategoriesEntity _$TopCategoriesEntityFromJson(Map<String, dynamic> json) =>
    TopCategoriesEntity(
      topGainers: (json['topGainers'] as List<dynamic>)
          .map((e) => TopGainersEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      topLoosers: (json['topLoosers'] as List<dynamic>)
          .map((e) => TopLoosersEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      topTurnover: (json['topTurnover'] as List<dynamic>)
          .map((e) => TopTurnoverEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      topVolume: (json['topVolume'] as List<dynamic>)
          .map((e) => TopVolumeEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      topTrans: (json['topTrans'] as List<dynamic>)
          .map((e) => TopTransactionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopCategoriesEntityToJson(
        TopCategoriesEntity instance) =>
    <String, dynamic>{
      'topGainers': instance.topGainers,
      'topLoosers': instance.topLoosers,
      'topTrans': instance.topTrans,
      'topTurnover': instance.topTurnover,
      'topVolume': instance.topVolume,
    };
