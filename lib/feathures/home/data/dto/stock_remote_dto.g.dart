// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRemoteDTO _$StockRemoteDTOFromJson(Map<String, dynamic> json) =>
    StockRemoteDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => StockRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFallback: json['isFallback'] as bool,
      isCached: json['isCached'] as bool,
      dataversion: DataVersionModel.fromJson(
          json['dataversion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockRemoteDTOToJson(StockRemoteDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
      'isFallback': instance.isFallback,
      'isCached': instance.isCached,
      'dataversion': instance.dataversion,
    };
