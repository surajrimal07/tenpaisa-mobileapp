import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_entity.g.dart';

final stockEntityProvider = StateProvider<StockEntity>((ref) {
  return const StockEntity(
    symbol: 'Null',
    ltp: 0,
    pointChange: 0.0,
    percentChange: 0.0,
    open: 0,
    high: 0,
    low: 0,
    volume: 0,
    previousClose: 0,
    name: 'Null',
    category: 'Null',
    sector: 'Null',
    turnover: 0,
    day120: 0,
    day180: 0,
    week52High: 0,
    week52Low: 0,
  );
});

@JsonSerializable()
class StockEntity extends Equatable {
  final String symbol;
  final double ltp;
  final double pointChange;
  final double percentChange;
  final double open;
  final double high;
  final double low;
  final int volume;
  final double previousClose;
  final String name;
  final String category;
  final String sector;
  final int? vwap;
  final int? turnover;
  final int? day120;
  final int? day180;
  final int? week52High;
  final int? week52Low;

  const StockEntity({
    required this.symbol,
    required this.ltp,
    required this.pointChange,
    required this.percentChange,
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.previousClose,
    required this.name,
    required this.category,
    required this.sector,
    this.vwap,
    this.turnover,
    this.day120,
    this.day180,
    this.week52High,
    this.week52Low,
  });

  factory StockEntity.fromJson(Map<String, dynamic> json) =>
      _$StockEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StockEntityToJson(this);

  double calculateVolatility() {
    double highLowRange = high - low;
    double volatility = (highLowRange / ltp) * 100.0;
    return volatility;
  }

  @override
  List<Object?> get props {
    return [
      symbol,
      ltp,
      pointChange,
      percentChange,
      open,
      high,
      low,
      volume,
      previousClose,
      name,
      category,
      sector,
      vwap,
      turnover,
      day120,
      day180,
      week52High,
      week52Low,
    ];
  }

  StockEntity toEntity() => StockEntity(
        symbol: symbol,
        ltp: ltp,
        pointChange: pointChange,
        percentChange: percentChange,
        open: open,
        high: high,
        low: low,
        volume: volume,
        previousClose: previousClose,
        name: name,
        category: category,
        sector: sector,
        vwap: vwap,
        turnover: turnover,
        day120: day120,
        day180: day180,
        week52High: week52High,
        week52Low: week52Low,
      );
}

extension StockEntityListExtensions on List<StockEntity> {
  List<StockEntity> shortByCategories(String category) {
    return where(
            (stock) => stock.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  List<StockEntity> shortBySector(String sector) {
    return where((stock) => stock.sector.toLowerCase() == sector.toLowerCase())
        .toList();
  }

  List<StockEntity> shortByVolatility() {
    return [...this]..sort(
        (a, b) => b.calculateVolatility().compareTo(a.calculateVolatility()));
  }
}
