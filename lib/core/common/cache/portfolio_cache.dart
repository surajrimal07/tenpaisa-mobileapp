import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_combined_local_model.dart';

final portfolioCacheProvider = Provider<PortfolioCache>((ref) {
  return PortfolioCache(
      hiveService: ref.read(hiveServiceProvider),
      portfolioLocalCombinedModel:
          ref.read(portfolioLocalCombinedModelProvider));
});

class PortfolioCache {
  final HiveService hiveService;
  final PortfolioLocalCombinedModel portfolioLocalCombinedModel;

  PortfolioCache(
      {required this.hiveService, required this.portfolioLocalCombinedModel});

  Future<void> addPortfolioData(PortfolioCombined portfolioCombined) async {
    await hiveService.addPortfolioData(
        portfolioLocalCombinedModel.toHiveModel(portfolioCombined));
  }
}
