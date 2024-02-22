import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/topgaines_entity.dart';
import 'package:uuid/uuid.dart';

part 'topgainers_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.topGainersTableId)
class TopGainersHiveModel {
  @HiveField(0)
  String topGainersId;
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

  TopGainersHiveModel({
    String? topGainersId,
    required this.symbol,
    required this.name,
    required this.ltp,
    required this.pointchange,
    required this.percentchange,
  }) : topGainersId = topGainersId ?? const Uuid().v4();

  factory TopGainersHiveModel.toHiveModel(TopGainersEntity model) {
    return TopGainersHiveModel(
      symbol: model.symbol,
      name: model.name,
      ltp: model.ltp,
      pointchange: model.pointchange,
      percentchange: model.percentchange,
    );
  }

  TopGainersEntity toEntity() => TopGainersEntity(
      symbol: symbol,
      name: name,
      ltp: ltp,
      pointchange: pointchange,
      percentchange: percentchange);

  TopGainersHiveModel.empty()
      : symbol = '',
        topGainersId = '',
        name = '',
        ltp = 0,
        pointchange = 0,
        percentchange = 0;

  TopGainersHiveModel fromEntity(TopGainersEntity entity) {
    return TopGainersHiveModel(
      symbol: entity.symbol,
      name: entity.name,
      ltp: entity.ltp,
      pointchange: entity.pointchange,
      percentchange: entity.percentchange,
    );
  }

  TopGainersHiveModel toHiveModel(TopGainersEntity entity) {
    return TopGainersHiveModel(
      symbol: entity.symbol,
      name: entity.name,
      ltp: entity.ltp,
      pointchange: entity.pointchange,
      percentchange: entity.percentchange,
    );
  }

  List<TopGainersHiveModel> toHiveModelList(List<TopGainersEntity> entity) {
    return entity
        .map((e) => TopGainersHiveModel(
              symbol: e.symbol,
              name: e.name,
              ltp: e.ltp,
              pointchange: e.pointchange,
              percentchange: e.percentchange,
            ))
        .toList();
  }

  List<TopGainersEntity> toEntityList(List<TopGainersHiveModel> entity) {
    return entity
        .map((e) => TopGainersEntity(
              symbol: e.symbol,
              name: e.name,
              ltp: e.ltp,
              pointchange: e.pointchange,
              percentchange: e.percentchange,
            ))
        .toList();
  }
}
