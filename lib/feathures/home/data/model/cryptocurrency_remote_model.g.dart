// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'cryptocurrency_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptocurrencyRemoteModel _$CryptocurrencyRemoteModelFromJson(
        Map<String, dynamic> json) =>
    CryptocurrencyRemoteModel(
      symbol: json['symbol'] as String,
      currency: json['currency'] as String,
      rate: json['rate'] as num,
      change: json['change'] as num,
    );

Map<String, dynamic> _$CryptocurrencyRemoteModelToJson(
        CryptocurrencyRemoteModel instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'currency': instance.currency,
      'rate': instance.rate,
      'change': instance.change,
    };
