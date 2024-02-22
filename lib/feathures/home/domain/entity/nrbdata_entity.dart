import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/domain/entity/currency_entity.dart';
import 'package:paisa/feathures/home/domain/entity/nrb_banking_entity.dart';
import 'package:paisa/feathures/home/domain/entity/nrbforex_entity.dart';

final nrbDataEntityProvider = StateProvider<NrbDataEntity>((ref) {
  return const NrbDataEntity(
    nrbBankingData: NrbBankingDataEntity(
      totalDeposits: '',
      commercialBanksTotalDeposits: '',
      otherBfIsTotalDeposits: '',
      totalLending: '',
      commercialBanksTotalLending: '',
      otherBfIsTotalLending: '',
      cdRatio: '',
      interbankInterestRateLcyWeightedAvg: '',
    ),
    nrbForexData: NrbForexEntity(
      currencyData: [
        CurrencyEntity(
          name: '',
          unit: 0,
          buy: 0.0,
          sell: 0.0,
        ),
      ],
    ),
  );
});

class NrbDataEntity extends Equatable {
  final NrbBankingDataEntity nrbBankingData;
  final NrbForexEntity nrbForexData;

  const NrbDataEntity({
    required this.nrbBankingData,
    required this.nrbForexData,
  });

  @override
  List<Object?> get props => [nrbBankingData, nrbForexData];

  NrbDataEntity toEntity() => NrbDataEntity(
        nrbBankingData: nrbBankingData.toEntity(),
        nrbForexData: nrbForexData.toEntity(),
      );

  static const dummy = NrbDataEntity(
      nrbBankingData: NrbBankingDataEntity(
        totalDeposits: '0',
        commercialBanksTotalDeposits: '0',
        otherBfIsTotalDeposits: '0',
        totalLending: '0',
        commercialBanksTotalLending: '0',
        otherBfIsTotalLending: '0',
        cdRatio: '0',
        interbankInterestRateLcyWeightedAvg: '0',
      ),
      nrbForexData: NrbForexEntity(
        currencyData: [
          CurrencyEntity(
            name: '',
            unit: 0,
            buy: 0,
            sell: 0,
          )
        ],
      ));

  factory NrbDataEntity.fromJson(Map<String, dynamic> json) {
    return NrbDataEntity(
      nrbBankingData: NrbBankingDataEntity.fromJson(json['nrbBankingData']),
      nrbForexData: NrbForexEntity.fromJson(json['nrbForexData']),
    );
  }
}
