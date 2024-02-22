import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_data.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_data_entity.dart';

part 'portfolio_data_local_model.g.dart';

final portfolioDataHiveModelProvider = Provider<PortfolioDataHiveModel>((ref) {
  return PortfolioDataHiveModel.empty();
});

@HiveType(typeId: HiveTableConstant.portfolioDataTableId)
class PortfolioDataHiveModel {
  @HiveField(1)
  final num totalPortfolioCost;
  @HiveField(2)
  final num totalPortfolioValue;
  @HiveField(3)
  final num totalPortfolioReturns;
  @HiveField(4)
  final double totalPortfolioReturnsPercentage;
  @HiveField(5)
  final int portfolioCount;
  @HiveField(6)
  final double averagePortfolioReturns;
  @HiveField(7)
  final double averagePortfolioReturnsPercentage;
  @HiveField(8)
  final int profitablePortfolios;
  @HiveField(9)
  final int unprofitablePortfolios;
  @HiveField(10)
  final String recommendation;
  @HiveField(11)
  final int totalStocks;
  @HiveField(12)
  final int totalUnits;

  PortfolioDataHiveModel({
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

  PortfolioDataHiveModel.empty()
      : this(
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

  PortfolioDataHiveModel toHiveModel(PortfolioDataEntity data) =>
      PortfolioDataHiveModel(
        totalPortfolioCost: data.totalPortfolioCost,
        totalPortfolioValue: data.totalPortfolioValue,
        totalPortfolioReturns: data.totalPortfolioReturns,
        totalPortfolioReturnsPercentage: data.totalPortfolioReturnsPercentage,
        portfolioCount: data.portfolioCount,
        averagePortfolioReturns: data.averagePortfolioReturns,
        averagePortfolioReturnsPercentage:
            data.averagePortfolioReturnsPercentage,
        profitablePortfolios: data.profitablePortfolios,
        unprofitablePortfolios: data.unprofitablePortfolios,
        recommendation: data.recommendation,
        totalStocks: data.totalStocks,
        totalUnits: data.totalUnits,
      );

  PortfolioDataEntity toEntity() => PortfolioDataEntity(
      totalPortfolioCost: totalPortfolioCost,
      totalPortfolioValue: totalPortfolioValue,
      totalPortfolioReturns: totalPortfolioReturns,
      totalPortfolioReturnsPercentage: totalPortfolioReturnsPercentage,
      portfolioCount: portfolioCount,
      averagePortfolioReturns: averagePortfolioReturns,
      averagePortfolioReturnsPercentage: averagePortfolioReturnsPercentage,
      profitablePortfolios: profitablePortfolios,
      unprofitablePortfolios: unprofitablePortfolios,
      recommendation: recommendation,
      totalStocks: totalStocks,
      totalUnits: totalUnits);

  PortfolioDataHiveModel fromEntity(PortfolioData data) =>
      PortfolioDataHiveModel(
        totalPortfolioCost: data.totalPortfolioCost,
        totalPortfolioValue: data.totalPortfolioValue,
        totalPortfolioReturns: data.totalPortfolioReturns,
        totalPortfolioReturnsPercentage: data.totalPortfolioReturnsPercentage,
        portfolioCount: data.portfolioCount,
        averagePortfolioReturns: data.averagePortfolioReturns,
        averagePortfolioReturnsPercentage:
            data.averagePortfolioReturnsPercentage,
        profitablePortfolios: data.profitablePortfolios,
        unprofitablePortfolios: data.unprofitablePortfolios,
        recommendation: data.recommendation,
        totalStocks: data.totalStocks,
        totalUnits: data.totalUnits,
      );

  List<PortfolioDataHiveModel> toHiveModelList(List<PortfolioData> data) =>
      data.map((e) => fromEntity(e)).toList();
}
