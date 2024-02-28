import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_data_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';

Future<PortfolioCombined> getPortfolioEntityTest() async {
  final response = await rootBundle.loadString('test_data/portfolio_test.json');

  final jsonList = await json.decode(response);

  final List<PortfolioEntity> portfolioList = jsonList
      .map<PortfolioEntity>((json) => PortfolioEntity.fromJson(json))
      .toList();

  const PortfolioDataEntity prtfolioData = PortfolioDataEntity(
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
    totalUnits: 0,
  );

  return Future.value(PortfolioCombined(
      portfolioEntityList: portfolioList, portfolioDataEntity: prtfolioData));
}
