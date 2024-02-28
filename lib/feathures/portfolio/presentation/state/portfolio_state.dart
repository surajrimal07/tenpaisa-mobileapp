import 'package:paisa/feathures/portfolio/domain/entity/portfolio_data_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';

class PortfolioState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<PortfolioEntity> portfoliosEntity;
  final PortfolioDataEntity portfolioDataEntity;

  PortfolioState(
      {required this.isLoading,
      this.error,
      required this.showMessage,
      required this.portfoliosEntity,
      required this.portfolioDataEntity});

  factory PortfolioState.initialState() => PortfolioState(
        isLoading: false,
        error: null,
        showMessage: false,
        portfoliosEntity: [],
        portfolioDataEntity: const PortfolioDataEntity(
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
            totalUnits: 0),
      );

  PortfolioState copyWith(
      {bool? isLoading,
      String? error,
      bool? showMessage,
      List<PortfolioEntity>? portfoliosEntity,
      PortfolioDataEntity? portfolioDataEntity}) {
    return PortfolioState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        portfoliosEntity: portfoliosEntity ?? this.portfoliosEntity,
        portfolioDataEntity: portfolioDataEntity ?? this.portfolioDataEntity);
  }

  bool get isPortfolioEmpty {
    return portfoliosEntity.isEmpty;
  }

  bool get isPortfolioNotEmpty {
    return portfoliosEntity.isNotEmpty;
  }
}
