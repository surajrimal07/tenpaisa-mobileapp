import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/data/model/shortterm_interest_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/nrb_banking_entity.dart';

part 'nrb_banking_local_model.g.dart';

// @HiveType(typeId: HiveTableConstant.nrbBankingLocalModelTableId)
// class NrbBankingLocalModel {
//   @HiveField(0)
//   String totalDeposits;
//   @HiveField(1)
//   String commercialBanksTotalDeposits;
//   @HiveField(2)
//   String otherBfIsTotalDeposits;
//   @HiveField(3)
//   String totalLending;
//   @HiveField(4)
//   String commercialBanksTotalLending;
//   @HiveField(5)
//   String otherBfIsTotalLending;
//   @HiveField(6)
//   String cdRatio;
//   @HiveField(7)
//   String interbankInterestRateLcyWeightedAvg;

//   NrbBankingLocalModel({
//     required this.totalDeposits,
//     required this.commercialBanksTotalDeposits,
//     required this.otherBfIsTotalDeposits,
//     required this.totalLending,
//     required this.commercialBanksTotalLending,
//     required this.otherBfIsTotalLending,
//     required this.cdRatio,
//     required this.interbankInterestRateLcyWeightedAvg,
//   });

//   NrbBankingLocalModel.empty()
//       : totalDeposits = '',
//         commercialBanksTotalDeposits = '',
//         otherBfIsTotalDeposits = '',
//         totalLending = '',
//         commercialBanksTotalLending = '',
//         otherBfIsTotalLending = '',
//         cdRatio = '',
//         interbankInterestRateLcyWeightedAvg = '';

//   NrbBankingLocalModel toHiveModel() => NrbBankingLocalModel(
//         totalDeposits: totalDeposits,
//         commercialBanksTotalDeposits: commercialBanksTotalDeposits,
//         otherBfIsTotalDeposits: otherBfIsTotalDeposits,
//         totalLending: totalLending,
//         commercialBanksTotalLending: commercialBanksTotalLending,
//         otherBfIsTotalLending: otherBfIsTotalLending,
//         cdRatio: cdRatio,
//         interbankInterestRateLcyWeightedAvg:
//             interbankInterestRateLcyWeightedAvg,
//       );

//   NrbBankingLocalModel.fromEntity(NrbBankingDataEntity entity)
//       : totalDeposits = entity.totalDeposits,
//         commercialBanksTotalDeposits = entity.commercialBanksTotalDeposits,
//         otherBfIsTotalDeposits = entity.otherBfIsTotalDeposits,
//         totalLending = entity.totalLending,
//         commercialBanksTotalLending = entity.commercialBanksTotalLending,
//         otherBfIsTotalLending = entity.otherBfIsTotalLending,
//         cdRatio = entity.cdRatio,
//         interbankInterestRateLcyWeightedAvg =
//             entity.interbankInterestRateLcyWeightedAvg;

//   NrbBankingDataEntity toEntity() => NrbBankingDataEntity(
//         totalDeposits: totalDeposits,
//         commercialBanksTotalDeposits: commercialBanksTotalDeposits,
//         otherBfIsTotalDeposits: otherBfIsTotalDeposits,
//         totalLending: totalLending,
//         commercialBanksTotalLending: commercialBanksTotalLending,
//         otherBfIsTotalLending: otherBfIsTotalLending,
//         cdRatio: cdRatio,
//         interbankInterestRateLcyWeightedAvg:
//             interbankInterestRateLcyWeightedAvg,
//       );
// }

@HiveType(typeId: HiveTableConstant.nrbBankingLocalModelTableId)
class NrbBankingLocalModel {
  @HiveField(0)
  Map<String, String> totalDeposits;

  @HiveField(1)
  Map<String, String> commercialBanksTotalDeposits;

  @HiveField(2)
  Map<String, String> otherBfIsTotalDeposits;

  @HiveField(3)
  Map<String, String> totalLending;

  @HiveField(4)
  Map<String, String> commercialBanksTotalLending;

  @HiveField(5)
  Map<String, String> otherBfIsTotalLending;

  @HiveField(6)
  Map<String, String> cdRatio;

  @HiveField(7)
  Map<String, String> interbankInterestRateLcyWeightedAvg;

  @HiveField(8)
  ShortTermInterestHiveModel shortTermInterestRates;

  NrbBankingLocalModel({
    required this.totalDeposits,
    required this.commercialBanksTotalDeposits,
    required this.otherBfIsTotalDeposits,
    required this.totalLending,
    required this.commercialBanksTotalLending,
    required this.otherBfIsTotalLending,
    required this.cdRatio,
    required this.interbankInterestRateLcyWeightedAvg,
    required this.shortTermInterestRates,
  });

  NrbBankingLocalModel.empty()
      : totalDeposits = {},
        commercialBanksTotalDeposits = {},
        otherBfIsTotalDeposits = {},
        totalLending = {},
        commercialBanksTotalLending = {},
        otherBfIsTotalLending = {},
        cdRatio = {},
        interbankInterestRateLcyWeightedAvg = {},
        shortTermInterestRates = ShortTermInterestHiveModel(
          values: {},
        );

  factory NrbBankingLocalModel.fromEntity(NrbBankingDataEntity entity) =>
      NrbBankingLocalModel(
        totalDeposits: entity.totalDeposits,
        commercialBanksTotalDeposits: entity.commercialBanksTotalDeposits,
        otherBfIsTotalDeposits: entity.otherBfIsTotalDeposits,
        totalLending: entity.totalLending,
        commercialBanksTotalLending: entity.commercialBanksTotalLending,
        otherBfIsTotalLending: entity.otherBfIsTotalLending,
        cdRatio: entity.cdRatio,
        interbankInterestRateLcyWeightedAvg:
            entity.interbankInterestRateLcyWeightedAvg,
        shortTermInterestRates: ShortTermInterestHiveModel(
          values: entity.shortTermInterestRates.values,
        ),
      );

  NrbBankingDataEntity toEntity() => NrbBankingDataEntity(
        totalDeposits: totalDeposits,
        commercialBanksTotalDeposits: commercialBanksTotalDeposits,
        otherBfIsTotalDeposits: otherBfIsTotalDeposits,
        totalLending: totalLending,
        commercialBanksTotalLending: commercialBanksTotalLending,
        otherBfIsTotalLending: otherBfIsTotalLending,
        cdRatio: {'ratio': cdRatio.toString()},
        interbankInterestRateLcyWeightedAvg: {
          'rate': interbankInterestRateLcyWeightedAvg.toString()
        },
        shortTermInterestRates: shortTermInterestRates.toEntity(),
      );
}
