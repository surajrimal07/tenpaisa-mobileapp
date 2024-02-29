// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'toploosers_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopLoosersRemoteModel _$TopLoosersRemoteModelFromJson(
        Map<String, dynamic> json) =>
    TopLoosersRemoteModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      pointchange: (json['pointchange'] as num).toDouble(),
      percentchange: (json['percentchange'] as num).toDouble(),
    );

Map<String, dynamic> _$TopLoosersRemoteModelToJson(
        TopLoosersRemoteModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'ltp': instance.ltp,
      'pointchange': instance.pointchange,
      'percentchange': instance.percentchange,
    };
