// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'global_market_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalMarketRemoteModel _$GlobalMarketRemoteModelFromJson(
        Map<String, dynamic> json) =>
    GlobalMarketRemoteModel(
      index: json['index'] as String,
      quote: json['quote'] as num,
      change: json['change'] as num,
      changepercentage: json['changepercentage'] as num,
    );

Map<String, dynamic> _$GlobalMarketRemoteModelToJson(
        GlobalMarketRemoteModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'quote': instance.quote,
      'change': instance.change,
      'changepercentage': instance.changepercentage,
    };
