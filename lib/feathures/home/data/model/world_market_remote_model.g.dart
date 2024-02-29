// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'world_market_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldMarketRemoteModel _$WorldMarketRemoteModelFromJson(
        Map<String, dynamic> json) =>
    WorldMarketRemoteModel(
      cryptocurrency: (json['cryptocurrency'] as List<dynamic>)
          .map((e) =>
              CryptocurrencyRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currencyExchangeRates: (json['currencyExchangeRates'] as List<dynamic>)
          .map((e) => CurrencyFxRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      asianMarketIndices: (json['asianMarketIndices'] as List<dynamic>)
          .map((e) =>
              GlobalMarketRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      europeanMarketIndices: (json['europeanMarketIndices'] as List<dynamic>)
          .map((e) =>
              GlobalMarketRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      americanMarketIndices: (json['americanMarketIndices'] as List<dynamic>)
          .map((e) =>
              GlobalMarketRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorldMarketRemoteModelToJson(
        WorldMarketRemoteModel instance) =>
    <String, dynamic>{
      'cryptocurrency': instance.cryptocurrency,
      'currencyExchangeRates': instance.currencyExchangeRates,
      'asianMarketIndices': instance.asianMarketIndices,
      'europeanMarketIndices': instance.europeanMarketIndices,
      'americanMarketIndices': instance.americanMarketIndices,
    };
