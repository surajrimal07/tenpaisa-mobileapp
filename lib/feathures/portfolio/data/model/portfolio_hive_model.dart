import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/portfolio/data/model/gainlossrecords_hive_model.dart';
import 'package:paisa/feathures/portfolio/data/model/userportfoliostoks_hive_mode.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:uuid/uuid.dart';

part 'portfolio_hive_model.g.dart';

final portfolioHiveModelProvider = Provider<PortfolioHiveModel>((ref) {
  return PortfolioHiveModel.empty();
});

@HiveType(typeId: HiveTableConstant.portfolioTableId)
class PortfolioHiveModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String userEmail;
  @HiveField(2)
  String name;
  @HiveField(3)
  List<UserPortfolioStockHiveModel>? stocks;
  @HiveField(4)
  int? totalunits;
  @HiveField(5)
  List<GainLossRecordHiveModel>? gainLossRecords;
  @HiveField(6)
  num? portfoliocost;
  @HiveField(7)
  num? portfoliovalue;
  @HiveField(8)
  String? recommendation;
  @HiveField(9)
  double? percentage;
  @HiveField(10)
  String? portfolioGoal;

  PortfolioHiveModel(
      {required this.id,
      required this.userEmail,
      required this.name,
      required this.stocks,
      required this.totalunits,
      required this.gainLossRecords,
      required this.portfoliocost,
      required this.portfoliovalue,
      required this.recommendation,
      required this.percentage,
      required this.portfolioGoal});

  PortfolioHiveModel.empty()
      : this(
          id: 'Empty',
          userEmail: "Empty",
          name: "Empty",
          stocks: [],
          totalunits: 0,
          gainLossRecords: [],
          portfoliocost: 0,
          portfoliovalue: 0,
          recommendation: "Empty",
          percentage: 0.0,
          portfolioGoal: "Not Set",
        );

  PortfolioEntity toEntity() => PortfolioEntity(
        id: id,
        userEmail: userEmail,
        name: name,
        stocks: stocks?.map((e) => e.toEntity()).toList() ?? [],
        totalunits: totalunits ?? 0,
        gainLossRecords:
            gainLossRecords?.map((e) => e.toEntity()).toList() ?? [],
        portfoliocost: portfoliocost ?? 0,
        portfoliovalue: portfoliovalue ?? 0,
        recommendation: recommendation ?? '',
        percentage: percentage ?? 0.0,
        portfolioGoal: portfolioGoal ?? '',
      );

  PortfolioHiveModel fromEntity(PortfolioEntity entity) => PortfolioHiveModel(
        id: entity.id,
        userEmail: entity.userEmail,
        name: entity.name,
        stocks:
            UserPortfolioStockHiveModel.empty().toHiveModelList(entity.stocks!),
        totalunits: entity.totalunits,
        gainLossRecords: GainLossRecordHiveModel.empty()
            .toHiveModelList(entity.gainLossRecords!),
        portfoliocost: entity.portfoliocost,
        portfoliovalue: entity.portfoliovalue,
        recommendation: entity.recommendation,
        percentage: entity.percentage,
        portfolioGoal: entity.portfolioGoal,
      );

  PortfolioHiveModel toHiveModel(PortfolioEntity entity) => PortfolioHiveModel(
        id: const Uuid().v4(),
        userEmail: entity.userEmail,
        name: entity.name,
        stocks:
            UserPortfolioStockHiveModel.empty().toHiveModelList(entity.stocks!),
        totalunits: entity.totalunits,
        gainLossRecords: GainLossRecordHiveModel.empty()
            .toHiveModelList(entity.gainLossRecords!),
        portfoliocost: entity.portfoliocost,
        portfoliovalue: entity.portfoliovalue,
        recommendation: entity.recommendation,
        percentage: entity.percentage,
        portfolioGoal: entity.portfolioGoal,
      );

  List<PortfolioHiveModel> toHiveModelList(
          List<PortfolioEntity> portfolioEntities) =>
      portfolioEntities.map((entity) => toHiveModel(entity)).toList();

  List<PortfolioEntity> toEntityList(
          List<PortfolioHiveModel> portfolioHiveModels) =>
      portfolioHiveModels.map((model) => model.toEntity()).toList();
}
