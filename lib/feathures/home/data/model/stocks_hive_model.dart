import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:uuid/uuid.dart';

part 'stocks_hive_model.g.dart';

final stockHiveModelProvider = Provider((ref) => StocksHiveModel.empty());

@HiveType(typeId: HiveTableConstant.stocksTableId)
class StocksHiveModel {
  @HiveField(0)
  final String? symbolId;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final double ltp;
  @HiveField(3)
  final double pointchange;
  @HiveField(4)
  final double percentchange;
  @HiveField(5)
  final String name;
  @HiveField(6)
  final double high;
  @HiveField(7)
  final double low;
  @HiveField(8)
  final double open;
  @HiveField(9)
  final int volume;
  @HiveField(10)
  final double previousClose;
  @HiveField(11)
  final String category;
  @HiveField(12)
  final int? vwap;
  @HiveField(13)
  final int? turnover;
  @HiveField(14)
  final int? day120;
  @HiveField(15)
  final int? day180;
  @HiveField(16)
  final int? week52High;
  @HiveField(17)
  final int? week52Low;
  @HiveField(18)
  final String sector;

  StocksHiveModel({
    String? symbolId,
    required this.symbol,
    required this.ltp,
    required this.pointchange,
    required this.percentchange,
    required this.name,
    required this.high,
    required this.low,
    required this.sector,
    required this.open,
    required this.volume,
    required this.previousClose,
    required this.category,
    this.vwap,
    this.turnover,
    this.day120,
    this.day180,
    this.week52High,
    this.week52Low,
  }) : symbolId = symbolId ?? const Uuid().v4();

  StocksHiveModel.empty()
      : symbolId = '',
        symbol = '',
        ltp = 0,
        pointchange = 0,
        percentchange = 0,
        name = '',
        high = 0,
        low = 0,
        open = 0,
        volume = 0,
        previousClose = 0,
        category = '',
        vwap = 0,
        turnover = 0,
        day120 = 0,
        day180 = 0,
        week52Low = 0,
        sector = '',
        week52High = 0;

  StocksHiveModel toHiveModel(StockEntity model) {
    return StocksHiveModel(
      symbol: model.symbol,
      ltp: model.ltp,
      pointchange: model.pointChange,
      percentchange: model.percentChange,
      name: model.name,
      high: model.high,
      low: model.low,
      open: model.open,
      volume: model.volume,
      previousClose: model.previousClose,
      category: model.category,
      vwap: model.vwap,
      sector: model.sector,
      turnover: model.turnover,
      day120: model.day120,
      day180: model.day180,
      week52High: model.week52High,
      week52Low: model.week52Low,
    );
  }

  StockEntity toEntity() => StockEntity(
        symbol: symbol,
        ltp: ltp,
        pointChange: pointchange,
        percentChange: percentchange,
        open: open,
        high: high,
        low: low,
        volume: volume,
        previousClose: previousClose,
        name: name,
        sector: sector,
        category: category,
        vwap: vwap ?? 0,
        turnover: turnover ?? 0,
        day120: day120 ?? 0,
        day180: day180 ?? 0,
        week52High: week52High ?? 0,
        week52Low: week52Low ?? 0,
      );

  StockEntity fromEntity(StockEntity entity) {
    return StockEntity(
      symbol: entity.symbol,
      ltp: entity.ltp,
      pointChange: entity.pointChange,
      percentChange: entity.percentChange,
      name: entity.name,
      high: entity.high,
      low: entity.low,
      open: entity.open,
      sector: entity.sector,
      volume: entity.volume,
      previousClose: entity.previousClose,
      category: entity.category,
      vwap: entity.vwap,
      turnover: entity.turnover,
      day120: entity.day120,
      day180: entity.day180,
      week52High: entity.week52High,
      week52Low: entity.week52Low,
    );
  }

  List<StocksHiveModel> toHiveModelList(List<StockEntity> entity) {
    return entity
        .map((e) => StocksHiveModel(
              symbolId: e.symbol,
              symbol: e.symbol,
              ltp: e.ltp,
              pointchange: e.pointChange,
              percentchange: e.percentChange,
              name: e.name,
              high: e.high,
              low: e.low,
              open: e.open,
              sector: e.sector,
              volume: e.volume,
              previousClose: e.previousClose,
              category: e.category,
              vwap: e.vwap,
              turnover: e.turnover,
              day120: e.day120,
              day180: e.day180,
              week52High: e.week52High,
              week52Low: e.week52Low,
            ))
        .toList();
  }

  List<StockEntity> toEntityList(List<StocksHiveModel> entity) =>
      entity.map((e) => e.toEntity()).toList();
}
