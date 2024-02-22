// // class PortfolioCalculationsState {
// //   final bool isLoading;
// //   final String? error;
// //   final bool showMessage;

// //   final double totalInvestment;
// //   final double totalCurrentValue;
// //   final double totalProfitLoss;
// //   final double totalProfitLossPercentage;
// //   final int totalPortfolio;
// //   final int totalStocks;
// //   final int totalUnits;
// //   final double averagePortfolioReturns;
// //   final double averagePortfolioReturnsPercentage;
// //   final int profitLossPortfolioRatio;

// //   PortfolioCalculationsState({
// //     required this.totalInvestment,
// //     required this.totalCurrentValue,
// //     required this.totalProfitLoss,
// //     required this.totalProfitLossPercentage,
// //     required this.totalPortfolio,
// //     required this.totalStocks,
// //     required this.totalUnits,
// //     required this.averagePortfolioReturns,
// //     required this.averagePortfolioReturnsPercentage,
// //     required this.profitLossPortfolioRatio,
// //     required this.isLoading,
// //     this.error,
// //     required this.showMessage,
// //   });

// //   factory PortfolioCalculationsState.initialState() =>
// //       PortfolioCalculationsState(
// //         totalInvestment: 0,
// //         totalCurrentValue: 0,
// //         totalProfitLoss: 0,
// //         totalProfitLossPercentage: 0,
// //         totalPortfolio: 0,
// //         totalStocks: 0,
// //         totalUnits: 0,
// //         averagePortfolioReturns: 0,
// //         averagePortfolioReturnsPercentage: 0,
// //         profitLossPortfolioRatio: 0,
// //         isLoading: false,
// //         error: null,
// //         showMessage: false,
// //       );

// //   PortfolioCalculationsState copyWith({
// //     double? totalInvestment,
// //     double? totalCurrentValue,
// //     double? totalProfitLoss,
// //     double? totalProfitLossPercentage,
// //     int? totalPortfolio,
// //     int? totalStocks,
// //     int? totalUnits,
// //     double? averagePortfolioReturns,
// //     double? averagePortfolioReturnsPercentage,
// //     int? profitLossPortfolioRatio,
// //     bool? isLoading,
// //     String? error,
// //     bool? showMessage,
// //   }) {
// //     return PortfolioCalculationsState(
// //       totalInvestment: totalInvestment ?? this.totalInvestment,
// //       totalCurrentValue: totalCurrentValue ?? this.totalCurrentValue,
// //       totalProfitLoss: totalProfitLoss ?? this.totalProfitLoss,
// //       totalProfitLossPercentage:
// //           totalProfitLossPercentage ?? this.totalProfitLossPercentage,
// //       totalPortfolio: totalPortfolio ?? this.totalPortfolio,
// //       totalStocks: totalStocks ?? this.totalStocks,
// //       totalUnits: totalUnits ?? this.totalUnits,
// //       averagePortfolioReturns:
// //           averagePortfolioReturns ?? this.averagePortfolioReturns,
// //       averagePortfolioReturnsPercentage: averagePortfolioReturnsPercentage ??
// //           this.averagePortfolioReturnsPercentage,
// //       profitLossPortfolioRatio:
// //           profitLossPortfolioRatio ?? this.profitLossPortfolioRatio,
// //       isLoading: isLoading ?? this.isLoading,
// //       error: error ?? this.error,
// //       showMessage: showMessage ?? this.showMessage,
// //     );
// //   }
// // }

// import 'package:paisa/feathures/portfolio/domain/entity/portfolio_data_entity.dart';

// class PortfolioDataState {
//   final bool isLoading;
//   final String? error;
//   final bool showMessage;
//   final PortfolioDataEntity portfolioDataEntity;

//   PortfolioDataState({
//     required this.isLoading,
//     this.error,
//     required this.showMessage,
//     required this.portfolioDataEntity,
//   });

//   factory PortfolioDataState.initialState() => PortfolioDataState(
//       isLoading: false,
//       error: null,
//       showMessage: false,
//       portfolioDataEntity: const PortfolioDataEntity(
//         totalPortfolioCost: 0,
//         totalPortfolioValue: 0,
//         totalPortfolioReturns: 0,
//         totalPortfolioReturnsPercentage: 0.0,
//         portfolioCount: 0,
//         averagePortfolioReturns: 0.0,
//         averagePortfolioReturnsPercentage: 0.0,
//         profitablePortfolios: 0,
//         unprofitablePortfolios: 0,
//         recommendation: '',
//       ));

//   PortfolioDataState copyWith({
//     bool? isLoading,
//     String? error,
//     bool? showMessage,
//     PortfolioDataEntity? portfolioDataEntity,
//   }) {
//     return PortfolioDataState(
//         isLoading: isLoading ?? this.isLoading,
//         error: error ?? this.error,
//         showMessage: showMessage ?? this.showMessage,
//         portfolioDataEntity: portfolioDataEntity ?? this.portfolioDataEntity);
//   }
// }
