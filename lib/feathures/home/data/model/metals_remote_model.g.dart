// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'metals_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetalRemoteModel _$MetalRemoteModelFromJson(Map<String, dynamic> json) =>
    MetalRemoteModel(
      unit: json['unit'] as String,
      id: json['_id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      sector: json['sector'] as String,
      ltp: (json['ltp'] as num).toDouble(),
    );

Map<String, dynamic> _$MetalRemoteModelToJson(MetalRemoteModel instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      '_id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'category': instance.category,
      'sector': instance.sector,
      'ltp': instance.ltp,
    };
