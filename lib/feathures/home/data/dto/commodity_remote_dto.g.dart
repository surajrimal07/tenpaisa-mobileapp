// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityDTO _$CommodityDTOFromJson(Map<String, dynamic> json) => CommodityDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => CommodityRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFallback: json['isFallback'] as bool,
      isCached: json['isCached'] as bool,
      dataversion: DataVersionModel.fromJson(
          json['dataversion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommodityDTOToJson(CommodityDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
      'isFallback': instance.isFallback,
      'isCached': instance.isCached,
      'dataversion': instance.dataversion,
    };
