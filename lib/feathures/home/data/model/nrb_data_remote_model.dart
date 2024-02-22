import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/data/model/nrb_banking_remote_model.dart';
import 'package:paisa/feathures/home/data/model/nrbforex_remote_data.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';

final nrbRemoteDataModelProvider = Provider<NrbRemoteDataModel>((ref) {
  return NrbRemoteDataModel(
    nrbBankingData: ref.read(nrbBankingRemoteModelProvider),
    nrbForexData: ref.read(nrbForexRemoteDataProvider),
  );
});


class NrbRemoteDataModel {
  NrbBankingRemoteModel nrbBankingData;
  NrbForexRemoteData nrbForexData;

  NrbRemoteDataModel(
      {required this.nrbBankingData, required this.nrbForexData});

  NrbDataEntity toEntity() => NrbDataEntity(
        nrbBankingData: nrbBankingData.toEntity(),
        nrbForexData: nrbForexData.toEntity(),
  );

  factory NrbRemoteDataModel.fromJson(Map<String, dynamic> json) {
    var nrbBankingData = NrbBankingRemoteModel.fromJson(json['nrbBankingData']);
    var nrbForexData = NrbForexRemoteData.fromJson(json['nrbForexData']);

    return NrbRemoteDataModel(
      nrbBankingData: nrbBankingData,
      nrbForexData: nrbForexData,
    );
  }
}
