import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nrb_banking_entity.g.dart';

final nrbBankingEntityProvider = StateProvider<NrbBankingDataEntity>((ref) =>
    const NrbBankingDataEntity(
        totalDeposits: '',
        commercialBanksTotalDeposits: '',
        otherBfIsTotalDeposits: '',
        totalLending: '',
        commercialBanksTotalLending: '',
        otherBfIsTotalLending: '',
        cdRatio: '',
        interbankInterestRateLcyWeightedAvg: ''));

@JsonSerializable()
class NrbBankingDataEntity extends Equatable {
  final String totalDeposits;
  final String commercialBanksTotalDeposits;
  final String otherBfIsTotalDeposits;
  final String totalLending;
  final String commercialBanksTotalLending;
  final String otherBfIsTotalLending;
  final String cdRatio;
  final String interbankInterestRateLcyWeightedAvg;

  const NrbBankingDataEntity({
    required this.totalDeposits,
    required this.commercialBanksTotalDeposits,
    required this.otherBfIsTotalDeposits,
    required this.totalLending,
    required this.commercialBanksTotalLending,
    required this.otherBfIsTotalLending,
    required this.cdRatio,
    required this.interbankInterestRateLcyWeightedAvg,
  });

  @override
  List<Object?> get props => [
        totalDeposits,
        commercialBanksTotalDeposits,
        otherBfIsTotalDeposits,
        totalLending,
        commercialBanksTotalLending,
        otherBfIsTotalLending,
        cdRatio,
        interbankInterestRateLcyWeightedAvg,
      ];
  factory NrbBankingDataEntity.fromJson(Map<String, dynamic> json) =>
      _$NrbBankingDataEntityFromJson(json);

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
}
