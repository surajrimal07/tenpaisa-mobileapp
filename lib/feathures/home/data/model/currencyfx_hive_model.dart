import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/currencyfx_entity.dart';

part 'currencyfx_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.currencyTableId)
class CurrencyfxHiveModel {
  @HiveField(0)
  String currency;
  @HiveField(1)
  num rate;
  @HiveField(2)
  num change;
  @HiveField(3)
  num changepercentage;

  CurrencyfxHiveModel(
      {required this.currency,
      required this.rate,
      required this.change,
      required this.changepercentage});

  factory CurrencyfxHiveModel.toHiveModel(CurrencyfxHiveModel model) {
    return CurrencyfxHiveModel(
      currency: model.currency,
      rate: model.rate,
      change: model.change,
      changepercentage: model.changepercentage,
    );
  }

  CurrencyFxEntity toEntity(CurrencyfxHiveModel model) {
    return CurrencyFxEntity(
      currency: model.currency,
      rate: model.rate,
      change: model.change,
      changepercentage: model.changepercentage,
    );
  }

  CurrencyfxHiveModel.empty()
      : change = 0,
        rate = 0,
        currency = '',
        changepercentage = 0;

  CurrencyfxHiveModel fromEntity(CurrencyFxEntity entity) {
    return CurrencyfxHiveModel(
      currency: entity.currency,
      rate: entity.rate,
      change: entity.change,
      changepercentage: entity.changepercentage,
    );
  }

  CurrencyfxHiveModel toHiveModel(CurrencyfxHiveModel entity) {
    return CurrencyfxHiveModel(
      currency: entity.currency,
      rate: entity.rate,
      change: entity.change,
      changepercentage: entity.changepercentage,
    );
  }

  List<CurrencyfxHiveModel> toHiveModelList(List<CurrencyFxEntity> entity) =>
      entity
          .map((e) => CurrencyfxHiveModel(
                currency: e.currency,
                rate: e.rate,
                change: e.change,
                changepercentage: e.changepercentage,
              ))
          .toList();

  List<CurrencyFxEntity> toEntityList(List<CurrencyfxHiveModel> entity) =>
      entity
          .map((e) => CurrencyFxEntity(
                currency: e.currency,
                rate: e.rate,
                change: e.change,
                changepercentage: e.changepercentage,
              ))
          .toList();
}
