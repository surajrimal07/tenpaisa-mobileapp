import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/global_market_entity.dart';

part 'globalmarket_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.globalMarketTableId)
class GlobalMarketHiveModel {
  @HiveField(0)
  String index;
  @HiveField(1)
  num quote;
  @HiveField(2)
  num change;
  @HiveField(3)
  num changepercentage;

  GlobalMarketHiveModel(
      {required this.index,
      required this.quote,
      required this.change,
      required this.changepercentage});

  factory GlobalMarketHiveModel.toHiveModel(GlobalMarketHiveModel model) {
    return GlobalMarketHiveModel(
      index: model.index,
      quote: model.quote,
      change: model.change,
      changepercentage: model.changepercentage,
    );
  }

  GlobalMarketHiveModel fromEntity(GlobalMarketEntity entity) {
    return GlobalMarketHiveModel(
      index: entity.index,
      quote: entity.quote,
      change: entity.change,
      changepercentage: entity.changepercentage,
    );
  }

  GlobalMarketEntity toEntity(GlobalMarketHiveModel model) {
    return GlobalMarketEntity(
      index: model.index,
      quote: model.quote,
      change: model.change,
      changepercentage: model.changepercentage,
    );
  }

  List<GlobalMarketEntity> toEntityList(List<GlobalMarketHiveModel> model) {
    return model.map((e) => e.toEntity(e)).toList();
  }

  GlobalMarketHiveModel.empty()
      : change = 0,
        quote = 0,
        index = '',
        changepercentage = 0;

  GlobalMarketHiveModel toHiveModel(GlobalMarketHiveModel entity) {
    return GlobalMarketHiveModel(
      index: entity.index,
      quote: entity.quote,
      change: entity.change,
      changepercentage: entity.changepercentage,
    );
  }

  List<GlobalMarketHiveModel> toHiveModelList(
          List<GlobalMarketEntity> entity) =>
      entity
          .map((e) => GlobalMarketHiveModel(
                index: e.index,
                quote: e.quote,
                change: e.change,
                changepercentage: e.changepercentage,
              ))
          .toList();
}
