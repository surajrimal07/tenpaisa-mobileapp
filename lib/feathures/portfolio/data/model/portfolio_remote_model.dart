import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/portfolio/data/model/gainlossrecord_remote_model.dart';
import 'package:paisa/feathures/portfolio/data/model/userportfoliostock_remote_model.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';

part 'portfolio_remote_model.g.dart';

final portfolioModelProvider = Provider<PortfolioModel>((ref) {
  return PortfolioModel(
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
});

@JsonSerializable()
class PortfolioModel {
  @JsonKey(name: '_id')
  String id;
  String userEmail;
  String name;
  List<UserPortfolioStock>? stocks;
  int? totalunits;
  List<GainLossRecord>? gainLossRecords;
  num? portfoliocost;
  num? portfoliovalue;
  String? recommendation;
  double? percentage;
  String? portfolioGoal;

  PortfolioModel(
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

  factory PortfolioModel.fromJson(Map<String, dynamic> json) =>
      _$PortfolioModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioModelToJson(this);

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
        portfolioGoal: portfolioGoal ?? "Not Set",
      );

  List<PortfolioEntity> toEntityList(List<PortfolioModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'PortfolioModel(id: $id, name: $name, userEmail: $userEmail, '
        'stocks: $stocks, totalunits: $totalunits, gainLossRecords: $gainLossRecords, '
        'portfoliocost: $portfoliocost, portfoliovalue: $portfoliovalue, recommendation: $recommendation, percentage: $percentage)';
  }
}
