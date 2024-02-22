import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/domain/entity/currency_entity.dart';

part 'nrb_currency_local_model.g.dart';

@HiveType(typeId: HiveTableConstant.currencyFxTableId)
class CurrencyLocalModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int unit;
  @HiveField(2)
  num buy;
  @HiveField(3)
  num sell;

  CurrencyLocalModel({
    required this.name,
    required this.unit,
    required this.buy,
    required this.sell,
  });

  CurrencyLocalModel.empty()
      : name = '',
        unit = 0,
        buy = 0.0,
        sell = 0.0;

  CurrencyLocalModel toHiveModel(CurrencyEntity model) {
    return CurrencyLocalModel(
      name: model.name,
      unit: model.unit,
      buy: model.buy,
      sell: model.sell,
    );
  }

  CurrencyLocalModel.fromEntity(CurrencyEntity entity)
      : name = entity.name,
        unit = entity.unit,
        buy = entity.buy,
        sell = entity.sell;

  CurrencyEntity toEntity() => CurrencyEntity(
        name: name,
        unit: unit,
        buy: buy,
        sell: sell,
      );

  List<CurrencyLocalModel> toHiveModelList(List<CurrencyEntity> model) {
    return model.map((e) => CurrencyLocalModel.fromEntity(e)).toList();
  }

  List<CurrencyEntity> toEntityList(List<CurrencyLocalModel> model) {
    return model.map((e) => e.toEntity()).toList();
  }
}
