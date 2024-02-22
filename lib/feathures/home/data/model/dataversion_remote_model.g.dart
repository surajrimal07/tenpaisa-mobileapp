// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataversion_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataVersionModel _$DataVersionModelFromJson(Map<String, dynamic> json) =>
    DataVersionModel(
      versionCode: json['versionCode'] as int,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$DataVersionModelToJson(DataVersionModel instance) =>
    <String, dynamic>{
      'versionCode': instance.versionCode,
      'timestamp': instance.timestamp,
    };
