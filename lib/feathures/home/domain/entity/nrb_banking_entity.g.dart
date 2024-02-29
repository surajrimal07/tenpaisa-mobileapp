// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'nrb_banking_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NrbBankingDataEntity _$NrbBankingDataEntityFromJson(
        Map<String, dynamic> json) =>
    NrbBankingDataEntity(
      totalDeposits: Map<String, String>.from(json['totalDeposits'] as Map),
      commercialBanksTotalDeposits:
          Map<String, String>.from(json['commercialBanksTotalDeposits'] as Map),
      otherBfIsTotalDeposits:
          Map<String, String>.from(json['otherBfIsTotalDeposits'] as Map),
      totalLending: Map<String, String>.from(json['totalLending'] as Map),
      commercialBanksTotalLending:
          Map<String, String>.from(json['commercialBanksTotalLending'] as Map),
      otherBfIsTotalLending:
          Map<String, String>.from(json['otherBfIsTotalLending'] as Map),
      cdRatio: Map<String, String>.from(json['cdRatio'] as Map),
      interbankInterestRateLcyWeightedAvg: Map<String, String>.from(
          json['interbankInterestRateLcyWeightedAvg'] as Map),
      shortTermInterestRates: ShortTermInterestEntity.fromJson(
          json['shortTermInterestRates'] as Map<String, dynamic>),
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
      'shortTermInterestRates': instance.shortTermInterestRates,
    };
