import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/data/model/topgainers_hive_model.dart';
import 'package:paisa/feathures/home/data/model/toploosers_hive_model.dart';
import 'package:paisa/feathures/home/data/model/toptransaction_hive_model.dart';
import 'package:paisa/feathures/home/data/model/topturnover_hive_model.dart';
import 'package:paisa/feathures/home/data/model/topvolume_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';
import 'package:uuid/uuid.dart';

part 'categories_hive_model.g.dart';

final categoriesHiveModelProvider = Provider<CategoriesHiveModel>((ref) {
  return CategoriesHiveModel(
    topGainers: [],
    topLosers: [],
    topTurnover: [],
    topVolume: [],
    topTrans: [],
  );
});

@HiveType(typeId: HiveTableConstant.categoriesTableId)
class CategoriesHiveModel {
  @HiveField(0)
  final String categoriesId;
  @HiveField(1)
  final List<TopGainersHiveModel> topGainers;
  @HiveField(2)
  final List<TopLoosersHiveModel> topLosers;
  @HiveField(3)
  final List<TopVolumeHiveModel> topVolume;
  @HiveField(4)
  final List<TopTransactionHiveModel> topTrans;
  @HiveField(5)
  final List<TopTurnoverHiveModel> topTurnover;

  CategoriesHiveModel(
      {String? categoriesId,
      required this.topGainers,
      required this.topLosers,
      required this.topVolume,
      required this.topTrans,
      required this.topTurnover})
      : categoriesId = categoriesId ?? const Uuid().v4();

  CategoriesHiveModel.empty()
      : categoriesId = '',
        topGainers = [],
        topLosers = [],
        topVolume = [],
        topTrans = [],
        topTurnover = [];

  CategoriesHiveModel toHiveModel(TopCategoriesEntity model) =>
      CategoriesHiveModel(
          topGainers:
              TopGainersHiveModel.empty().toHiveModelList(model.topGainers),
          topLosers:
              TopLoosersHiveModel.empty().toHiveModelList(model.topLoosers),
          topVolume:
              TopVolumeHiveModel.empty().toHiveModelList(model.topVolume),
          topTrans:
              TopTransactionHiveModel.empty().toHiveModelList(model.topTrans),
          topTurnover:
              TopTurnoverHiveModel.empty().toHiveModelList(model.topTurnover));

  TopCategoriesEntity toEntity() => TopCategoriesEntity(
      topGainers: TopGainersHiveModel.empty().toEntityList(topGainers),
      topLoosers: TopLoosersHiveModel.empty().toEntityList(topLosers),
      topTurnover: TopTurnoverHiveModel.empty().toEntityList(topTurnover),
      topVolume: TopVolumeHiveModel.empty().toEntityList(topVolume),
      topTrans: TopTransactionHiveModel.empty().toEntityList(topTrans));

  CategoriesHiveModel fromEntity(TopCategoriesEntity entity) =>
      CategoriesHiveModel(
          topGainers:
              TopGainersHiveModel.empty().toHiveModelList(entity.topGainers),
          topLosers:
              TopLoosersHiveModel.empty().toHiveModelList(entity.topLoosers),
          topVolume:
              TopVolumeHiveModel.empty().toHiveModelList(entity.topVolume),
          topTrans:
              TopTransactionHiveModel.empty().toHiveModelList(entity.topTrans),
          topTurnover:
              TopTurnoverHiveModel.empty().toHiveModelList(entity.topTurnover));
}
