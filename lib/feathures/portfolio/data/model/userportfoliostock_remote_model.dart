//user stock array (inside user) model
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';

part 'userportfoliostock_remote_model.g.dart';

final userPortfolioStockModeProvider = Provider<UserPortfolioStock>((ref) {
  return UserPortfolioStock.dummy();
});

@JsonSerializable()
class UserPortfolioStock {
  @JsonKey(name: '_id')
  String id;
  String symbol;
  int quantity;
  double wacc;
  double currentprice;
  String name;
  double ltp;
  double costprice;
  double netgainloss;

  UserPortfolioStock({
    required this.id,
    required this.symbol,
    required this.quantity,
    required this.wacc,
    required this.currentprice,
    required this.name,
    required this.ltp,
    required this.costprice,
    required this.netgainloss,
  });

  factory UserPortfolioStock.fromJson(Map<String, dynamic> json) =>
      _$UserPortfolioStockFromJson(json);

  Map<String, dynamic> toJson() => _$UserPortfolioStockToJson(this);

  UserPortfolioStockEntity toEntity() => UserPortfolioStockEntity(
      id: id,
      symbol: symbol,
      quantity: quantity,
      wacc: wacc,
      currentPrice: currentprice,
      stockName: name,
      ltp: ltp,
      costPrice: costprice,
      netGainLoss: netgainloss);

  List<UserPortfolioStockEntity> toEntityList(
          List<UserPortfolioStock> models) =>
      models.map((model) => model.toEntity()).toList();

  UserPortfolioStock.dummy()
      : id = "Empty",
        symbol = "Empty",
        quantity = 0,
        wacc = 0,
        currentprice = 0,
        name = "Empty",
        ltp = 0,
        costprice = 0,
        netgainloss = 0;

  @override
  String toString() {
    return 'PortfolioStock(id: $id, symbol: $symbol, quantity: $quantity, wacc: $wacc, currentprice: $currentprice, name: $name, ltp: $ltp, costprice: $costprice, netgainloss: $netgainloss)';
  }
}
