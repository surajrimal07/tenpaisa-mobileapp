// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userportfoliostock_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPortfolioStock _$UserPortfolioStockFromJson(Map<String, dynamic> json) =>
    UserPortfolioStock(
      id: json['_id'] as String,
      symbol: json['symbol'] as String,
      quantity: json['quantity'] as int,
      wacc: (json['wacc'] as num).toDouble(),
      currentprice: (json['currentprice'] as num).toDouble(),
      name: json['name'] as String,
      ltp: (json['ltp'] as num).toDouble(),
      costprice: (json['costprice'] as num).toDouble(),
      netgainloss: (json['netgainloss'] as num).toDouble(),
    );

Map<String, dynamic> _$UserPortfolioStockToJson(UserPortfolioStock instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'symbol': instance.symbol,
      'quantity': instance.quantity,
      'wacc': instance.wacc,
      'currentprice': instance.currentprice,
      'name': instance.name,
      'ltp': instance.ltp,
      'costprice': instance.costprice,
      'netgainloss': instance.netgainloss,
    };
