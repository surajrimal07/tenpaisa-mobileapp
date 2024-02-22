import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';
import 'package:uuid/uuid.dart';

part 'index_hive_model.g.dart';

final indexHiveModelProvider =
    Provider<IndexHiveModel>((ref) => IndexHiveModel.empty());

@HiveType(typeId: HiveTableConstant.indexTableId)
class IndexHiveModel {
  @HiveField(0)
  String? indexId;
  @HiveField(1)
  String date;
  @HiveField(2)
  num index;
  @HiveField(3)
  num percentageChange;
  @HiveField(4)
  num? pointChange;
  @HiveField(5)
  int? turnover;
  @HiveField(6)
  String? marketStatus;

  IndexHiveModel(
      {String? indexId,
      required this.date,
      required this.index,
      required this.percentageChange,
      this.pointChange,
      this.turnover,
      this.marketStatus})
      : indexId = indexId ?? const Uuid().v4();

  IndexHiveModel.empty()
      : indexId = '',
        date = '',
        index = 0,
        percentageChange = 0,
        pointChange = 0,
        turnover = 0,
        marketStatus = '';

  IndexHiveModel toHiveModel(IndexEntity model) {
    return IndexHiveModel(
        date: model.date,
        index: model.index,
        percentageChange: model.percentageChange,
        pointChange: model.pointChange,
        turnover: model.turnover,
        marketStatus: model.marketStatus);
  }

  IndexEntity toEntity() => IndexEntity(
      date: date,
      index: index,
      percentageChange: percentageChange,
      pointChange: pointChange,
      turnover: turnover,
      marketStatus: marketStatus);

  IndexHiveModel fromEntity(IndexEntity entity) {
    return IndexHiveModel(
        date: entity.date,
        index: entity.index,
        percentageChange: entity.percentageChange,
        pointChange: entity.pointChange,
        turnover: entity.turnover,
        marketStatus: entity.marketStatus);
  }

  List<IndexHiveModel> toHiveModelList(List<IndexEntity> entity) {
    return entity
        .map((e) => IndexHiveModel(
              date: e.date,
              index: e.index,
              percentageChange: e.percentageChange,
              pointChange: e.pointChange,
              turnover: e.turnover,
              marketStatus: e.marketStatus,
            ))
        .toList();
  }

  List<IndexEntity> toEntityList(List<IndexHiveModel> entity) {
    return entity
        .map((e) => IndexEntity(
              date: e.date,
              index: e.index,
              percentageChange: e.percentageChange,
              pointChange: e.pointChange,
              turnover: e.turnover,
              marketStatus: e.marketStatus,
            ))
        .toList();
  }
}
