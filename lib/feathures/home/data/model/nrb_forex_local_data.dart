import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/data/model/nrb_currency_local_model.dart';
import 'package:paisa/feathures/home/domain/entity/nrbforex_entity.dart';

part 'nrb_forex_local_data.g.dart';

@HiveType(typeId: HiveTableConstant.nrbForexLocalModelTableId)
class NrbForexLocalModel {
  @HiveField(0)
  List<CurrencyLocalModel> currency;

  NrbForexLocalModel({required this.currency});

  NrbForexLocalModel.empty()
      : currency = [
          CurrencyLocalModel.empty(),
        ];

  NrbForexLocalModel toHiveModel(NrbForexEntity model) {
    return NrbForexLocalModel(
        currency: model.currencyData
            .map((e) => CurrencyLocalModel.fromEntity(e))
            .toList());
  }

  NrbForexLocalModel.fromEntity(NrbForexEntity entity)
      : currency = entity.currencyData
            .map((e) => CurrencyLocalModel.fromEntity(e))
            .toList();

  NrbForexEntity toEntity() => NrbForexEntity(
        currencyData: currency.map((e) => e.toEntity()).toList(),
      );

  List<NrbForexLocalModel> toHiveModelList(List<NrbForexEntity> model) {
    return model.map((e) => NrbForexLocalModel.fromEntity(e)).toList();
  }

  List<NrbForexEntity> toEntityList(List<NrbForexLocalModel> model) {
    return model.map((e) => e.toEntity()).toList();
  }
}
