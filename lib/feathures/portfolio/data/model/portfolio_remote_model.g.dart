// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioModel _$PortfolioModelFromJson(Map<String, dynamic> json) =>
    PortfolioModel(
      id: json['_id'] as String,
      userEmail: json['userEmail'] as String,
      name: json['name'] as String,
      stocks: (json['stocks'] as List<dynamic>?)
          ?.map((e) => UserPortfolioStock.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalunits: json['totalunits'] as int?,
      gainLossRecords: (json['gainLossRecords'] as List<dynamic>?)
          ?.map((e) => GainLossRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      portfoliocost: json['portfoliocost'] as num?,
      portfoliovalue: json['portfoliovalue'] as num?,
      recommendation: json['recommendation'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      portfolioGoal: json['portfolioGoal'] as String?,
    );

Map<String, dynamic> _$PortfolioModelToJson(PortfolioModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userEmail': instance.userEmail,
      'name': instance.name,
      'stocks': instance.stocks,
      'totalunits': instance.totalunits,
      'gainLossRecords': instance.gainLossRecords,
      'portfoliocost': instance.portfoliocost,
      'portfoliovalue': instance.portfoliovalue,
      'recommendation': instance.recommendation,
      'percentage': instance.percentage,
      'portfolioGoal': instance.portfolioGoal,
    };
