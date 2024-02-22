//stock model, individual stock model
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';

part 'stock_remote_model.g.dart';

final stockRemoteModeProvider = Provider<StockRemoteModel>((ref) {
  return StockRemoteModel.dummy();
});

@JsonSerializable()
class StockRemoteModel {
  String symbol;
  double ltp;
  double pointchange;
  double percentchange;
  double open;
  double high;
  double low;
  int volume;
  double previousclose;
  String name;
  String category;
  String sector;
  int? vwap;
  @JsonKey(name: "Turnover")
  int? turnover;
  int? day120;
  int? day180;
  int? week52high;
  int? week52low;

  StockRemoteModel({
    required this.symbol,
    required this.ltp,
    required this.pointchange,
    required this.percentchange,
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.previousclose,
    required this.name,
    required this.category,
    required this.sector,
    required this.vwap,
    this.turnover,
    this.day120,
    this.day180,
    this.week52high,
    this.week52low,
  });

  factory StockRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$StockRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$StockRemoteModelToJson(this);

  StockEntity toEntity() => StockEntity(
        symbol: symbol,
        ltp: ltp,
        pointChange: pointchange,
        percentChange: percentchange,
        open: open,
        high: high,
        low: low,
        volume: volume,
        previousClose: previousclose,
        name: name,
        category: category,
        sector: sector,
        vwap: vwap ?? 0,
        turnover: turnover ?? 0,
        day120: day120 ?? 0,
        day180: day180 ?? 0,
        week52High: week52high ?? 0,
        week52Low: week52low ?? 0,
      );
      
  List<StockEntity> toEntityList(List<StockRemoteModel> list) =>
      list.map((item) => item.toEntity()).toList();

  factory StockRemoteModel.dummy() {
    return StockRemoteModel(
      symbol: "Empty",
      ltp: 0,
      pointchange: 0.0,
      percentchange: 0.0,
      open: 0,
      high: 0,
      low: 0,
      volume: 0,
      previousclose: 0,
      name: "Empty",
      category: "Empty",
      sector: "Empty",
      vwap: 0,
      turnover: 0,
      day120: 0,
      day180: 0,
      week52high: 0,
      week52low: 0,
    );
  }
}
