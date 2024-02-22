// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexEntity _$IndexEntityFromJson(Map<String, dynamic> json) => IndexEntity(
      date: json['date'] as String,
      index: json['index'] as num,
      percentageChange: json['percentageChange'] as num,
      pointChange: json['pointChange'] as num?,
      turnover: json['turnover'] as int?,
      marketStatus: json['marketStatus'] as String?,
    );

Map<String, dynamic> _$IndexEntityToJson(IndexEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'index': instance.index,
      'percentageChange': instance.percentageChange,
      'pointChange': instance.pointChange,
      'turnover': instance.turnover,
      'marketStatus': instance.marketStatus,
    };
