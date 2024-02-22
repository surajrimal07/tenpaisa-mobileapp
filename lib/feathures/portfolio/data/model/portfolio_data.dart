import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_data_entity.dart';

part 'portfolio_data.g.dart';

final portfolioDataProvider = Provider<PortfolioData>((ref) {
  return PortfolioData(
      totalPortfolioCost: 0,
      totalPortfolioValue: 0,
      totalPortfolioReturns: 0,
      totalPortfolioReturnsPercentage: 0.0,
      portfolioCount: 0,
      averagePortfolioReturns: 0.0,
      averagePortfolioReturnsPercentage: 0.0,
      profitablePortfolios: 0,
      unprofitablePortfolios: 0,
      recommendation: '',
      totalStocks: 0,
      totalUnits: 0);
});

@JsonSerializable()
class PortfolioData {
  final num totalPortfolioCost;
  final num totalPortfolioValue;
  final num totalPortfolioReturns;
  final double totalPortfolioReturnsPercentage;
  final int portfolioCount;
  final double averagePortfolioReturns;
  final double averagePortfolioReturnsPercentage;
  final int profitablePortfolios;
  final int unprofitablePortfolios;
  final String recommendation;
  final int totalStocks;
  final int totalUnits;

  PortfolioData(
      {required this.totalPortfolioCost,
      required this.totalPortfolioValue,
      required this.totalPortfolioReturns,
      required this.totalPortfolioReturnsPercentage,
      required this.portfolioCount,
      required this.averagePortfolioReturns,
      required this.averagePortfolioReturnsPercentage,
      required this.profitablePortfolios,
      required this.unprofitablePortfolios,
      required this.recommendation,
      required this.totalStocks,
      required this.totalUnits});

  factory PortfolioData.fromJson(Map<String, dynamic> json) =>
      _$PortfolioDataFromJson(json);

  PortfolioDataEntity toEntity(PortfolioData data) {
    return PortfolioDataEntity(
      totalPortfolioCost: data.totalPortfolioCost,
      totalPortfolioValue: data.totalPortfolioValue,
      totalPortfolioReturns: data.totalPortfolioReturns,
      totalPortfolioReturnsPercentage: data.totalPortfolioReturnsPercentage,
      portfolioCount: data.portfolioCount,
      averagePortfolioReturns: data.averagePortfolioReturns,
      averagePortfolioReturnsPercentage: data.averagePortfolioReturnsPercentage,
      profitablePortfolios: data.profitablePortfolios,
      unprofitablePortfolios: data.unprofitablePortfolios,
      recommendation: data.recommendation,
      totalStocks: data.totalStocks,
      totalUnits: data.totalUnits,
    );
  }

  PortfolioData dummyData() => PortfolioData(
      totalPortfolioCost: 0,
      totalPortfolioValue: 0,
      totalPortfolioReturns: 0,
      totalPortfolioReturnsPercentage: 0.0,
      portfolioCount: 0,
      averagePortfolioReturns: 0.0,
      averagePortfolioReturnsPercentage: 0.0,
      profitablePortfolios: 0,
      unprofitablePortfolios: 0,
      recommendation: '',
      totalStocks: 0,
      totalUnits: 0);
}
