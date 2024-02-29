// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'portfolio_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioData _$PortfolioDataFromJson(Map<String, dynamic> json) =>
    PortfolioData(
      totalPortfolioCost: json['totalPortfolioCost'] as num,
      totalPortfolioValue: json['totalPortfolioValue'] as num,
      totalPortfolioReturns: json['totalPortfolioReturns'] as num,
      totalPortfolioReturnsPercentage:
          (json['totalPortfolioReturnsPercentage'] as num).toDouble(),
      portfolioCount: json['portfolioCount'] as int,
      averagePortfolioReturns:
          (json['averagePortfolioReturns'] as num).toDouble(),
      averagePortfolioReturnsPercentage:
          (json['averagePortfolioReturnsPercentage'] as num).toDouble(),
      profitablePortfolios: json['profitablePortfolios'] as int,
      unprofitablePortfolios: json['unprofitablePortfolios'] as int,
      recommendation: json['recommendation'] as String,
      totalStocks: json['totalStocks'] as int,
      totalUnits: json['totalUnits'] as int,
    );

Map<String, dynamic> _$PortfolioDataToJson(PortfolioData instance) =>
    <String, dynamic>{
      'totalPortfolioCost': instance.totalPortfolioCost,
      'totalPortfolioValue': instance.totalPortfolioValue,
      'totalPortfolioReturns': instance.totalPortfolioReturns,
      'totalPortfolioReturnsPercentage':
          instance.totalPortfolioReturnsPercentage,
      'portfolioCount': instance.portfolioCount,
      'averagePortfolioReturns': instance.averagePortfolioReturns,
      'averagePortfolioReturnsPercentage':
          instance.averagePortfolioReturnsPercentage,
      'profitablePortfolios': instance.profitablePortfolios,
      'unprofitablePortfolios': instance.unprofitablePortfolios,
      'recommendation': instance.recommendation,
      'totalStocks': instance.totalStocks,
      'totalUnits': instance.totalUnits,
    };
