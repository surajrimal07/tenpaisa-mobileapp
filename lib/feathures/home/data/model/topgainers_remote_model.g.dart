// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'topgainers_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopGainersRemoteModel _$TopGainersRemoteModelFromJson(
        Map<String, dynamic> json) =>
    TopGainersRemoteModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      pointchange: (json['pointchange'] as num).toDouble(),
      percentchange: (json['percentchange'] as num).toDouble(),
    );

Map<String, dynamic> _$TopGainersRemoteModelToJson(
        TopGainersRemoteModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'ltp': instance.ltp,
      'pointchange': instance.pointchange,
      'percentchange': instance.percentchange,
    };
