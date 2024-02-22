import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/portfolio/domain/entity/lossgainrecord_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';

part 'portfolio_entity.g.dart';

class PortfolioListNotifier extends StateNotifier<List<PortfolioEntity>> {
  PortfolioListNotifier() : super([]);

  void setPortfolioList(List<PortfolioEntity> portfolios) {
    state = portfolios;
  }
}

@JsonSerializable()
class PortfolioEntity extends Equatable {
  final String id;
  final String userEmail;
  final String name;
  final List<UserPortfolioStockEntity>? stocks;
  final int? totalunits;
  final List<LossGainRecordsEntity>? gainLossRecords;
  final num? portfoliocost;
  final num? portfoliovalue;
  final String? recommendation;
  final double? percentage;
  final String? portfolioGoal;

  const PortfolioEntity(
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

  @override
  List<Object?> get props => [
        id,
        userEmail,
        name,
        stocks,
        totalunits,
        gainLossRecords,
        portfoliocost,
        portfoliovalue,
        recommendation,
        percentage,
        portfolioGoal
      ];

  factory PortfolioEntity.fromJson(Map<String, dynamic> json) =>
      _$PortfolioEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioEntityToJson(this);

  bool get isStockEmpty => stocks == null || stocks!.isEmpty;

  bool get isStockNotEmpty => stocks != null && stocks!.isNotEmpty;
}
