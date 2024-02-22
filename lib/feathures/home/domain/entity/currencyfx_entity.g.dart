// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currencyfx_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyFxEntity _$CurrencyFxEntityFromJson(Map<String, dynamic> json) =>
    CurrencyFxEntity(
      currency: json['currency'] as String,
      rate: json['rate'] as num,
      change: json['change'] as num,
      changepercentage: json['changepercentage'] as num,
    );

Map<String, dynamic> _$CurrencyFxEntityToJson(CurrencyFxEntity instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'rate': instance.rate,
      'change': instance.change,
      'changepercentage': instance.changepercentage,
    };
