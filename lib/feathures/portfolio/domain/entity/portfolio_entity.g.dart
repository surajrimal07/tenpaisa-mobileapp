// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioEntity _$PortfolioEntityFromJson(Map<String, dynamic> json) =>
    PortfolioEntity(
      id: json['id'] as String,
      userEmail: json['userEmail'] as String,
      name: json['name'] as String,
      stocks: (json['stocks'] as List<dynamic>?)
          ?.map((e) =>
              UserPortfolioStockEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalunits: json['totalunits'] as int?,
      gainLossRecords: (json['gainLossRecords'] as List<dynamic>?)
          ?.map(
              (e) => LossGainRecordsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      portfoliocost: json['portfoliocost'] as num?,
      portfoliovalue: json['portfoliovalue'] as num?,
      recommendation: json['recommendation'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      portfolioGoal: json['portfolioGoal'] as String?,
    );

Map<String, dynamic> _$PortfolioEntityToJson(PortfolioEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
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
