// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nrb_banking_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NrbBankingDataEntity _$NrbBankingDataEntityFromJson(
        Map<String, dynamic> json) =>
    NrbBankingDataEntity(
      totalDeposits: json['totalDeposits'] as String,
      commercialBanksTotalDeposits:
          json['commercialBanksTotalDeposits'] as String,
      otherBfIsTotalDeposits: json['otherBfIsTotalDeposits'] as String,
      totalLending: json['totalLending'] as String,
      commercialBanksTotalLending:
          json['commercialBanksTotalLending'] as String,
      otherBfIsTotalLending: json['otherBfIsTotalLending'] as String,
      cdRatio: json['cdRatio'] as String,
      interbankInterestRateLcyWeightedAvg:
          json['interbankInterestRateLcyWeightedAvg'] as String,
    );

Map<String, dynamic> _$NrbBankingDataEntityToJson(
        NrbBankingDataEntity instance) =>
    <String, dynamic>{
      'totalDeposits': instance.totalDeposits,
      'commercialBanksTotalDeposits': instance.commercialBanksTotalDeposits,
      'otherBfIsTotalDeposits': instance.otherBfIsTotalDeposits,
      'totalLending': instance.totalLending,
      'commercialBanksTotalLending': instance.commercialBanksTotalLending,
      'otherBfIsTotalLending': instance.otherBfIsTotalLending,
      'cdRatio': instance.cdRatio,
      'interbankInterestRateLcyWeightedAvg':
          instance.interbankInterestRateLcyWeightedAvg,
    };
