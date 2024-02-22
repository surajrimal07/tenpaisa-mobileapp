// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userportfoliostock_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPortfolioStockEntity _$UserPortfolioStockEntityFromJson(
        Map<String, dynamic> json) =>
    UserPortfolioStockEntity(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      quantity: json['quantity'] as int,
      wacc: (json['wacc'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
      stockName: json['stockName'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      costPrice: (json['costPrice'] as num).toDouble(),
      netGainLoss: (json['netGainLoss'] as num).toDouble(),
    );

Map<String, dynamic> _$UserPortfolioStockEntityToJson(
        UserPortfolioStockEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'quantity': instance.quantity,
      'wacc': instance.wacc,
      'currentPrice': instance.currentPrice,
      'stockName': instance.stockName,
      'ltp': instance.ltp,
      'costPrice': instance.costPrice,
      'netGainLoss': instance.netGainLoss,
    };
