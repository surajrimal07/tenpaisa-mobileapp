import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/domain/entity/nrb_banking_entity.dart';

final nrbBankingRemoteModelProvider = Provider<NrbBankingRemoteModel>((ref) {
  return NrbBankingRemoteModel(
    totalDeposits: '0',
    commercialBanksTotalDeposits: '0',
    otherBfIsTotalDeposits: '0',
    totalLending: '0',
    commercialBanksTotalLending: '0',
    otherBfIsTotalLending: '0',
    cdRatio: '0',
    interbankInterestRateLcyWeightedAvg: '0',
  );
});

class NrbBankingRemoteModel {
  final String totalDeposits;
  final String commercialBanksTotalDeposits;
  final String otherBfIsTotalDeposits;
  final String totalLending;
  final String commercialBanksTotalLending;
  final String otherBfIsTotalLending;
  final String cdRatio;
  final String interbankInterestRateLcyWeightedAvg;

  NrbBankingRemoteModel({
    required this.totalDeposits,
    required this.commercialBanksTotalDeposits,
    required this.otherBfIsTotalDeposits,
    required this.totalLending,
    required this.commercialBanksTotalLending,
    required this.otherBfIsTotalLending,
    required this.cdRatio,
    required this.interbankInterestRateLcyWeightedAvg,
  });

  NrbBankingDataEntity toEntity() => NrbBankingDataEntity(
        totalDeposits: totalDeposits,
        commercialBanksTotalDeposits: commercialBanksTotalDeposits,
        otherBfIsTotalDeposits: otherBfIsTotalDeposits,
        totalLending: totalLending,
        commercialBanksTotalLending: commercialBanksTotalLending,
        otherBfIsTotalLending: otherBfIsTotalLending,
        cdRatio: cdRatio,
        interbankInterestRateLcyWeightedAvg:
            interbankInterestRateLcyWeightedAvg,
      );

  factory NrbBankingRemoteModel.fromJson(Map<String, dynamic> json) {
    return NrbBankingRemoteModel(
      totalDeposits: json['Total Deposits'],
      commercialBanksTotalDeposits: json['Commercial Banks Total Deposits'],
      otherBfIsTotalDeposits: json['Other BFIs Total Deposits'],
      totalLending: json['Total Lending'],
      commercialBanksTotalLending: json['Commercial Banks Total Lending'],
      otherBfIsTotalLending: json['Other BFIs Total Lending'],
      cdRatio: json['CD Ratio'],
      interbankInterestRateLcyWeightedAvg:
          json['Interbank Interest Rate LCY - Weighted Avg.'],
    );
  }
}
