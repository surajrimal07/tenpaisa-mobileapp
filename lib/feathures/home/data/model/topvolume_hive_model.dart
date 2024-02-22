import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/topvolume_entity.dart';
import 'package:uuid/uuid.dart';

part 'topvolume_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.topVolumeTableId)
class TopVolumeHiveModel {
  @HiveField(0)
  final String topVolumeId;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final int volume;
  @HiveField(4)
  final double ltp;

  TopVolumeHiveModel({
    String? topVolumeId,
    required this.symbol,
    required this.name,
    required this.volume,
    required this.ltp,
  }) : topVolumeId = topVolumeId ?? const Uuid().v4();

  TopVolumeHiveModel.empty()
      : topVolumeId = '',
        symbol = '',
        name = '',
        volume = 0,
        ltp = 0;

  TopVolumeHiveModel toHiveModel(TopVolumeEntity model) {
    return TopVolumeHiveModel(
      symbol: model.symbol,
      name: model.name,
      volume: model.volume,
      ltp: model.ltp,
    );
  }

  TopVolumeEntity fromEntity(TopVolumeEntity entity) {
    return TopVolumeEntity(
      symbol: entity.symbol,
      name: entity.name,
      volume: entity.volume,
      ltp: entity.ltp,
    );
  }

  TopVolumeEntity toEntity() => TopVolumeEntity(
        symbol: symbol,
        name: name,
        volume: volume,
        ltp: ltp,
      );

  List<TopVolumeHiveModel> toHiveModelList(List<TopVolumeEntity> entity) {
    return entity
        .map((e) => TopVolumeHiveModel(
              symbol: e.symbol,
              name: e.name,
              volume: e.volume,
              ltp: e.ltp,
            ))
        .toList();
  }

  List<TopVolumeEntity> toEntityList(List<TopVolumeHiveModel> entity) {
    return entity
        .map((e) => TopVolumeEntity(
              symbol: e.symbol,
              name: e.name,
              volume: e.volume,
              ltp: e.ltp,
            ))
        .toList();
  }

  List<TopVolumeEntity> fromEntityList(List<TopVolumeHiveModel> entity) {
    return entity
        .map((e) => TopVolumeEntity(
              symbol: e.symbol,
              name: e.name,
              volume: e.volume,
              ltp: e.ltp,
            ))
        .toList();
  }
}
