import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';
import 'package:uuid/uuid.dart';

part 'userportfoliostoks_hive_mode.g.dart';

@HiveType(typeId: HiveTableConstant.userPortfolioStockTableId)
class UserPortfolioStockHiveModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String symbol;
  @HiveField(2)
  int quantity;
  @HiveField(3)
  double wacc;
  @HiveField(4)
  double currentprice;
  @HiveField(5)
  String name;
  @HiveField(6)
  double ltp;
  @HiveField(7)
  double costprice;
  @HiveField(8)
  double netgainloss;

  UserPortfolioStockHiveModel({
    String? id,
    required this.symbol,
    required this.quantity,
    required this.wacc,
    required this.currentprice,
    required this.name,
    required this.ltp,
    required this.costprice,
    required this.netgainloss,
  }) : id = id ?? const Uuid().v4();

  UserPortfolioStockHiveModel.empty()
      : this(
            id: "Empty",
            symbol: "Empty",
            quantity: 0,
            wacc: 0,
            currentprice: 0,
            name: "Empty",
            ltp: 0,
            costprice: 0,
            netgainloss: 0);

  UserPortfolioStockEntity toEntity() => UserPortfolioStockEntity(
        id: id,
        symbol: symbol,
        quantity: quantity,
        wacc: wacc,
        currentPrice: currentprice,
        stockName: name,
        ltp: ltp,
        costPrice: costprice,
        netGainLoss: netgainloss,
      );

  UserPortfolioStockHiveModel fromEntity(UserPortfolioStockEntity entity) =>
      UserPortfolioStockHiveModel(
        id: entity.id,
        symbol: entity.symbol,
        quantity: entity.quantity,
        wacc: entity.wacc,
        currentprice: entity.currentPrice,
        name: entity.stockName,
        ltp: entity.ltp,
        costprice: entity.costPrice,
        netgainloss: entity.netGainLoss,
      );

  UserPortfolioStockHiveModel toHiveModel(UserPortfolioStockEntity entity) =>
      UserPortfolioStockHiveModel(
        symbol: entity.symbol,
        quantity: entity.quantity,
        wacc: entity.wacc,
        currentprice: entity.currentPrice,
        name: entity.stockName,
        ltp: entity.ltp,
        costprice: entity.costPrice,
        netgainloss: entity.netGainLoss,
      );

  List<UserPortfolioStockHiveModel> toHiveModelList(
          List<UserPortfolioStockEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  List<UserPortfolioStockEntity> toEntityList(
          List<UserPortfolioStockHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'UserPortfolioStockHiveModel(id: $id, symbol: $symbol, quantity: $quantity, wacc: $wacc, currentprice: $currentprice, name: $name, ltp: $ltp, costprice: $costprice, netgainloss: $netgainloss)';
  }
}
