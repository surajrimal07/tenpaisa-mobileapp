import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_data_local_model.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_hive_model.dart';

part 'portfolio_combined_local_model.g.dart';

final portfolioLocalCombinedModelProvider =
    Provider<PortfolioLocalCombinedModel>((ref) {
  final portfolioDataHiveModel = ref.watch(portfolioDataHiveModelProvider);
  final portfolioHiveModelList = ref.watch(portfolioHiveModelProvider);
  return PortfolioLocalCombinedModel(
      portfolioDataHiveModel: portfolioDataHiveModel,
      portfolioHiveModelList: [portfolioHiveModelList]);
});

@HiveType(typeId: HiveTableConstant.portfolioCombinedTableId)
class PortfolioLocalCombinedModel {
  @HiveField(0)
  final PortfolioDataHiveModel portfolioDataHiveModel;
  @HiveField(1)
  final List<PortfolioHiveModel> portfolioHiveModelList;

  PortfolioLocalCombinedModel(
      {required this.portfolioDataHiveModel,
      required this.portfolioHiveModelList});

  PortfolioLocalCombinedModel.empty()
      : portfolioDataHiveModel = PortfolioDataHiveModel.empty(),
        portfolioHiveModelList = [PortfolioHiveModel.empty()];

  PortfolioCombined toEntity() => PortfolioCombined(
      portfolioDataEntity: portfolioDataHiveModel.toEntity(),
      portfolioEntityList:
          portfolioHiveModelList.map((e) => e.toEntity()).toList());

  PortfolioLocalCombinedModel toHiveModel(
          PortfolioCombined portfolioCombined) =>
      PortfolioLocalCombinedModel(
          portfolioDataHiveModel: portfolioDataHiveModel
              .toHiveModel(portfolioCombined.portfolioDataEntity),
          portfolioHiveModelList: portfolioHiveModelList);
}
