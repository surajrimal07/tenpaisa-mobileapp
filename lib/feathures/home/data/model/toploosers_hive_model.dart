
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/toploosers_entity.dart';
import 'package:uuid/uuid.dart';

part 'toploosers_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.topLoosersTableId)
class TopLoosersHiveModel {
  @HiveField(0)
  String topLoosersId;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final double ltp;
  @HiveField(4)
  final double pointchange;
  @HiveField(5)
  final double percentchange;

  TopLoosersHiveModel({
    String? topLoosersId,
    required this.symbol,
    required this.name,
    required this.ltp,
    required this.pointchange,
    required this.percentchange,
  }) : topLoosersId = topLoosersId ?? const Uuid().v4();

  TopLoosersHiveModel.empty()
      : symbol = '',
        topLoosersId = '',
        name = '',
        ltp = 0,
        pointchange = 0,
        percentchange = 0;

  factory TopLoosersHiveModel.toHiveModel(TopLoosersEntity model) {
    return TopLoosersHiveModel(
      symbol: model.symbol,
      name: model.name,
      ltp: model.ltp,
      pointchange: model.pointchange,
      percentchange: model.percentchange,
    );
  }

  TopLoosersEntity toEntity() => TopLoosersEntity(
        symbol: symbol,
        name: name,
        ltp: ltp,
        pointchange: pointchange,
        percentchange: percentchange,
      );

  TopLoosersEntity fromEntity(TopLoosersEntity entity) {
    return TopLoosersEntity(
      symbol: entity.symbol,
      name: entity.name,
      ltp: entity.ltp,
      pointchange: entity.pointchange,
      percentchange: entity.percentchange,
    );
  }

  TopLoosersHiveModel toHiveModel(TopLoosersEntity entity) {
    return TopLoosersHiveModel(
      symbol: entity.symbol,
      name: entity.name,
      ltp: entity.ltp,
      pointchange: entity.pointchange,
      percentchange: entity.percentchange,
    );
  }

  List<TopLoosersHiveModel> toHiveModelList(List<TopLoosersEntity> entity) {
    return entity
        .map((e) => TopLoosersHiveModel(
              symbol: e.symbol,
              name: e.name,
              ltp: e.ltp,
              pointchange: e.pointchange,
              percentchange: e.percentchange,
            ))
        .toList();
  }

  List<TopLoosersEntity> toEntityList(List<TopLoosersHiveModel> entity) {
    return entity
        .map((e) => TopLoosersEntity(
              symbol: e.symbol,
              name: e.name,
              ltp: e.ltp,
              pointchange: e.pointchange,
              percentchange: e.percentchange,
            ))
        .toList();
  }
}
