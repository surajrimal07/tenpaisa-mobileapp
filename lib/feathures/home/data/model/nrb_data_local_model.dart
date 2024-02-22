import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/data/model/nrb_banking_local_model.dart';
import 'package:paisa/feathures/home/data/model/nrb_forex_local_data.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';

part 'nrb_data_local_model.g.dart';

final nrbDataLocalHiveModelProvider =
    Provider<NrbDataLocalHiveModel>((ref) => NrbDataLocalHiveModel.empty());

@HiveType(typeId: HiveTableConstant.nrbboxId)
class NrbDataLocalHiveModel {
  @HiveField(0)
  NrbBankingLocalModel nrbBankingData;
  @HiveField(1)
  NrbForexLocalModel nrbForexData;

  NrbDataLocalHiveModel({
    required this.nrbBankingData,
    required this.nrbForexData,
  });

  NrbDataLocalHiveModel.empty()
      : nrbBankingData = NrbBankingLocalModel.empty(),
        nrbForexData = NrbForexLocalModel.empty();

  NrbDataLocalHiveModel.fromEntity(NrbDataEntity entity)
      : nrbBankingData = NrbBankingLocalModel.fromEntity(entity.nrbBankingData),
        nrbForexData = NrbForexLocalModel.fromEntity(entity.nrbForexData);

  NrbDataEntity toEntity() => NrbDataEntity(
        nrbBankingData: nrbBankingData.toEntity(),
        nrbForexData: nrbForexData.toEntity(),
      );

  NrbDataLocalHiveModel toHiveModel(NrbDataEntity model) {
    return NrbDataLocalHiveModel(
      nrbBankingData: NrbBankingLocalModel.fromEntity(model.nrbBankingData),
      nrbForexData: NrbForexLocalModel.fromEntity(model.nrbForexData),
    );
  }

  List<NrbDataLocalHiveModel> toHiveModelList(List<NrbDataEntity> model) {
    return model.map((e) => NrbDataLocalHiveModel.fromEntity(e)).toList();
  }

  List<NrbDataEntity> toEntityList(List<NrbDataLocalHiveModel> model) {
    return model.map((e) => e.toEntity()).toList();
  }
}
