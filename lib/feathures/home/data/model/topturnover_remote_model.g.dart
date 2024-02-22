// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topturnover_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopTurnoverRemoteModel _$TopTurnoverRemoteModelFromJson(
        Map<String, dynamic> json) =>
    TopTurnoverRemoteModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      turnover: (json['turnover'] as num).toDouble(),
      ltp: (json['ltp'] as num).toDouble(),
    );

Map<String, dynamic> _$TopTurnoverRemoteModelToJson(
        TopTurnoverRemoteModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'turnover': instance.turnover,
      'ltp': instance.ltp,
    };
