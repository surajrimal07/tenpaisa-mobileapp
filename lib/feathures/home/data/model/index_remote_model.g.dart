// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexRemoteModel _$IndexRemoteModelFromJson(Map<String, dynamic> json) =>
    IndexRemoteModel(
      date: json['date'] as String,
      index: (json['index'] as num).toDouble(),
      percentageChange: (json['percentageChange'] as num).toDouble(),
      pointChange: (json['pointChange'] as num?)?.toDouble(),
      turnover: json['turnover'] as int?,
      marketStatus: json['marketStatus'] as String?,
    );

Map<String, dynamic> _$IndexRemoteModelToJson(IndexRemoteModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'index': instance.index,
      'percentageChange': instance.percentageChange,
      'pointChange': instance.pointChange,
      'turnover': instance.turnover,
      'marketStatus': instance.marketStatus,
    };
