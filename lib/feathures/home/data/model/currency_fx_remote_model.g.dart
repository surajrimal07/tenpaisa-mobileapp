// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'currency_fx_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyFxRemoteModel _$CurrencyFxRemoteModelFromJson(
        Map<String, dynamic> json) =>
    CurrencyFxRemoteModel(
      currency: json['currency'] as String,
      rate: json['rate'] as num,
      change: json['change'] as num,
      changepercentage: json['changepercentage'] as num,
    );

Map<String, dynamic> _$CurrencyFxRemoteModelToJson(
        CurrencyFxRemoteModel instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'rate': instance.rate,
      'change': instance.change,
      'changepercentage': instance.changepercentage,
    };
