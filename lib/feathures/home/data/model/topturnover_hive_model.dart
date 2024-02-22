import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/topturnover_entity.dart';
import 'package:uuid/uuid.dart';

part 'topturnover_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.topTurnoverTableId)
class TopTurnoverHiveModel {
  @HiveField(0)
  String topTurnoverId;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final double turnover;
  @HiveField(4)
  final double ltp;

  TopTurnoverHiveModel({
    String? topTurnoverId,
    required this.symbol,
    required this.name,
    required this.turnover,
    required this.ltp,
  }) : topTurnoverId = topTurnoverId ?? const Uuid().v4();

  factory TopTurnoverHiveModel.toHiveModel(TopTurnoverHiveModel model) {
    return TopTurnoverHiveModel(
      symbol: model.symbol,
      name: model.name,
      turnover: model.turnover,
      ltp: model.ltp,
    );
  }

  TopTurnoverHiveModel.empty()
      : symbol = '',
        topTurnoverId = '',
        name = '',
        turnover = 0,
        ltp = 0;

  TopTurnoverEntity fromEntity(TopTurnoverEntity entity) {
    return TopTurnoverEntity(
      symbol: entity.symbol,
      name: entity.name,
      turnover: entity.turnover,
      ltp: entity.ltp,
    );
  }

  TopTurnoverEntity toEntity() => TopTurnoverEntity(
        symbol: symbol,
        name: name,
        turnover: turnover,
        ltp: ltp,
      );

  TopTurnoverHiveModel toHiveModel(TopTurnoverEntity entity) {
    return TopTurnoverHiveModel(
      symbol: entity.symbol,
      name: entity.name,
      turnover: entity.turnover,
      ltp: entity.ltp,
    );
  }

  List<TopTurnoverHiveModel> toHiveModelList(List<TopTurnoverEntity> entity) {
    return entity
        .map((e) => TopTurnoverHiveModel(
              symbol: e.symbol,
              name: e.name,
              turnover: e.turnover,
              ltp: e.ltp,
            ))
        .toList();
  }

  List<TopTurnoverEntity> toEntityList(List<TopTurnoverHiveModel> entity) {
    return entity
        .map((e) => TopTurnoverEntity(
              symbol: e.symbol,
              name: e.name,
              turnover: e.turnover,
              ltp: e.ltp,
            ))
        .toList();
  }
}
