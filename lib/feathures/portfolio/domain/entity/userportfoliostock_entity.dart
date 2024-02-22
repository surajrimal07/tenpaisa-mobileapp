import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userportfoliostock_entity.g.dart';

@JsonSerializable()
class UserPortfolioStockEntity extends Equatable {
  final String id;
  final String symbol;
  final int quantity;
  final double wacc;
  final double currentPrice;
  final String stockName;
  final double ltp;
  final double costPrice;
  final double netGainLoss;

  const UserPortfolioStockEntity({
    required this.id,
    required this.symbol,
    required this.quantity,
    required this.wacc,
    required this.currentPrice,
    required this.stockName,
    required this.ltp,
    required this.costPrice,
    required this.netGainLoss,
  });

  @override
  List<Object?> get props {
    return [
      id,
      symbol,
      quantity,
      wacc,
      currentPrice,
      stockName,
      ltp,
      costPrice,
      netGainLoss,
    ];
  }

  factory UserPortfolioStockEntity.fromJson(Map<String, dynamic> json) =>
      _$UserPortfolioStockEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserPortfolioStockEntityToJson(this);
}
