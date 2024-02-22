import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';

part 'commodity_local_model.g.dart';

final commodityLocalHiveModelProvider =
    Provider<CommodityLocalHiveModel>((ref) => CommodityLocalHiveModel.empty());

@HiveType(typeId: HiveTableConstant.commodityTableId)
class CommodityLocalHiveModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? symbol;
  @HiveField(2)
  String name;
  @HiveField(3)
  String category;
  @HiveField(4)
  double ltp;
  @HiveField(5)
  String unit;

  CommodityLocalHiveModel({
    this.id,
    this.symbol,
    required this.name,
    required this.category,
    required this.ltp,
    required this.unit,
  });

  CommodityLocalHiveModel.empty()
      : id = '',
        symbol = '',
        name = '',
        category = '',
        unit = '',
        ltp = 0.0;

  CommodityLocalHiveModel toHiveModel(CommodityEntity model) {
    return CommodityLocalHiveModel(
        id: model.id,
        symbol: model.symbol,
        name: model.name,
        category: model.category,
        ltp: model.ltp,
        unit: model.unit);
  }

  CommodityEntity toEntity() => CommodityEntity(
      id: id,
      symbol: symbol,
      name: name,
      category: category,
      ltp: ltp,
      unit: unit);

  CommodityLocalHiveModel fromEntity(CommodityEntity entity) {
    return CommodityLocalHiveModel(
        id: entity.id,
        symbol: entity.symbol,
        name: entity.name,
        category: entity.category,
        ltp: entity.ltp,
        unit: entity.unit);
  }

  List<CommodityLocalHiveModel> toHiveModelList(List<CommodityEntity> entity) {
    return entity
        .map((e) => CommodityLocalHiveModel(
              id: e.id,
              symbol: e.symbol,
              name: e.name,
              category: e.category,
              ltp: e.ltp,
              unit: e.unit,
            ))
        .toList();
  }

  List<CommodityEntity> toEntityList(List<CommodityLocalHiveModel> entity) {
    return entity
        .map((e) => CommodityEntity(
              id: e.id,
              symbol: e.symbol,
              name: e.name,
              category: e.category,
              ltp: e.ltp,
              unit: e.unit,
            ))
        .toList();
  }
}
