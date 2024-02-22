import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';
import 'package:uuid/uuid.dart';

part 'metals_hive_model.g.dart';

final metalsHiveModelProvider = Provider<MetalsHiveModel>((ref) {
  return MetalsHiveModel(
    unit: '',
    id: '',
    symbol: '',
    name: '',
    category: '',
    sector: '',
    ltp: 0.0,
  );
});

@HiveType(typeId: HiveTableConstant.metalTableId)
class MetalsHiveModel {
  @HiveField(0)
  String? metalId;
  @HiveField(1)
  String unit;
  @HiveField(2)
  String id;
  @HiveField(3)
  String symbol;
  @HiveField(4)
  String name;
  @HiveField(5)
  String category;
  @HiveField(6)
  String sector;
  @HiveField(7)
  double ltp;

  MetalsHiveModel(
      {String? metalId,
      required this.unit,
      required this.id,
      required this.symbol,
      required this.name,
      required this.category,
      required this.sector,
      required this.ltp})
      : metalId = metalId ?? const Uuid().v4();

  MetalsHiveModel.empty()
      : metalId = '',
        unit = '',
        id = '',
        symbol = '',
        name = '',
        category = '',
        sector = '',
        ltp = 0.0;

  MetalsHiveModel toHiveModel(MetalsEnity model) {
    return MetalsHiveModel(
        unit: model.unit,
        id: model.id,
        symbol: model.symbol,
        name: model.name,
        category: model.category,
        sector: model.sector,
        ltp: model.ltp);
  }

  MetalsEnity toEntity() => MetalsEnity(
        unit: unit,
        id: id,
        symbol: symbol,
        name: name,
        category: category,
        sector: sector,
        ltp: ltp,
      );

  MetalsHiveModel fromEntity(MetalsEnity entity) {
    return MetalsHiveModel(
        unit: entity.unit,
        id: entity.id,
        symbol: entity.symbol,
        name: entity.name,
        category: entity.category,
        sector: entity.sector,
        ltp: entity.ltp);
  }

  List<MetalsHiveModel> toHiveModelList(List<MetalsEnity> entity) {
    return entity
        .map((e) => MetalsHiveModel(
              unit: e.unit,
              id: e.id,
              symbol: e.symbol,
              name: e.name,
              category: e.category,
              sector: e.sector,
              ltp: e.ltp,
            ))
        .toList();
  }

  List<MetalsEnity> toEntityList(List<MetalsHiveModel> entity) {
    return entity
        .map((e) => MetalsEnity(
              unit: e.unit,
              id: e.id,
              symbol: e.symbol,
              name: e.name,
              category: e.category,
              sector: e.sector,
              ltp: e.ltp,
            ))
        .toList();
  }
}
