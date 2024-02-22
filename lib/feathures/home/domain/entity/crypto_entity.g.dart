// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoEntity _$CryptoEntityFromJson(Map<String, dynamic> json) => CryptoEntity(
      symbol: json['symbol'] as String,
      currency: json['currency'] as String,
      rate: json['rate'] as num,
      change: json['change'] as num,
    );

Map<String, dynamic> _$CryptoEntityToJson(CryptoEntity instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'currency': instance.currency,
      'rate': instance.rate,
      'change': instance.change,
    };
