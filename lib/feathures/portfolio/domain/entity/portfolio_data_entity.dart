import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'portfolio_data_entity.g.dart';

final portfolioDataEntityProvider = StateProvider<PortfolioDataEntity>((ref) {
  return const PortfolioDataEntity(
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
class PortfolioDataEntity extends Equatable {
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

  const PortfolioDataEntity({
    required this.totalPortfolioCost,
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
    required this.totalUnits,
  });

  @override
  List<Object?> get props => [
        totalPortfolioCost,
        totalPortfolioValue,
        totalPortfolioReturns,
        totalPortfolioReturnsPercentage,
        portfolioCount,
        averagePortfolioReturns,
        averagePortfolioReturnsPercentage,
        profitablePortfolios,
        unprofitablePortfolios,
        recommendation,
        totalStocks,
        totalUnits
      ];
  PortfolioDataEntity dummyData() {
    return const PortfolioDataEntity(
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

  factory PortfolioDataEntity.fromJson(Map<String, dynamic> json) =>
      _$PortfolioDataEntityFromJson(json);
}
