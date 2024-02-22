import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/data/model/cryptocurrency_hive_model.dart';
import 'package:paisa/feathures/home/data/model/currencyfx_hive_model.dart';
import 'package:paisa/feathures/home/data/model/globalmarket_hive_model.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';
import 'package:uuid/uuid.dart';

part 'world_market_hive_model.g.dart';

final worldMarkethiveModelPRovider = Provider<WorldMarketHiveModel>((ref) {
  return WorldMarketHiveModel.empty();
});

@HiveType(typeId: HiveTableConstant.worldMarketTableId)
class WorldMarketHiveModel {
  @HiveField(0)
  final String worldMarketId;
  @HiveField(1)
  List<CryptoCurrencyHiveModel> cryptocurrency;
  @HiveField(2)
  List<CurrencyfxHiveModel> currencyExchangeRates;
  @HiveField(3)
  List<GlobalMarketHiveModel> asianMarketIndices;
  @HiveField(4)
  List<GlobalMarketHiveModel> europeanMarketIndices;
  @HiveField(5)
  List<GlobalMarketHiveModel> americanMarketIndices;

  WorldMarketHiveModel({
    String? worldMarketId,
    required this.cryptocurrency,
    required this.currencyExchangeRates,
    required this.asianMarketIndices,
    required this.europeanMarketIndices,
    required this.americanMarketIndices,
  }) : worldMarketId = worldMarketId ?? const Uuid().v4();

  factory WorldMarketHiveModel.toHiveModel(WorldMarketHiveModel model) {
    return WorldMarketHiveModel(
      cryptocurrency: model.cryptocurrency,
      currencyExchangeRates: model.currencyExchangeRates,
      asianMarketIndices: model.asianMarketIndices,
      europeanMarketIndices: model.europeanMarketIndices,
      americanMarketIndices: model.americanMarketIndices,
    );
  }

  WorldMarketEntity toEntity() => WorldMarketEntity(
        cryptocurrency:
            CryptoCurrencyHiveModel.empty().toEntityList(cryptocurrency),
        forex: CurrencyfxHiveModel.empty().toEntityList(currencyExchangeRates),
        asianmarket:
            GlobalMarketHiveModel.empty().toEntityList(asianMarketIndices),
        europeanMarket:
            GlobalMarketHiveModel.empty().toEntityList(europeanMarketIndices),
        americanmarket:
            GlobalMarketHiveModel.empty().toEntityList(americanMarketIndices),
      );

  WorldMarketHiveModel fromEntity(WorldMarketEntity entity) =>
      WorldMarketHiveModel(
        cryptocurrency: CryptoCurrencyHiveModel.empty()
            .toHiveModelList(entity.cryptocurrency),
        currencyExchangeRates:
            CurrencyfxHiveModel.empty().toHiveModelList(entity.forex),
        asianMarketIndices:
            GlobalMarketHiveModel.empty().toHiveModelList(entity.asianmarket),
        europeanMarketIndices: GlobalMarketHiveModel.empty()
            .toHiveModelList(entity.europeanMarket),
        americanMarketIndices: GlobalMarketHiveModel.empty()
            .toHiveModelList(entity.americanmarket),
      );

  WorldMarketHiveModel.empty()
      : this(
          worldMarketId: '',
          cryptocurrency: [],
          currencyExchangeRates: [],
          asianMarketIndices: [],
          europeanMarketIndices: [],
          americanMarketIndices: [],
        );

  WorldMarketHiveModel toHiveModel(WorldMarketEntity entity) =>
      WorldMarketHiveModel(
        worldMarketId: const Uuid().v4(),
        cryptocurrency: CryptoCurrencyHiveModel.empty()
            .toHiveModelList(entity.cryptocurrency),
        currencyExchangeRates:
            CurrencyfxHiveModel.empty().toHiveModelList(entity.forex),
        asianMarketIndices:
            GlobalMarketHiveModel.empty().toHiveModelList(entity.asianmarket),
        europeanMarketIndices: GlobalMarketHiveModel.empty()
            .toHiveModelList(entity.europeanMarket),
        americanMarketIndices: GlobalMarketHiveModel.empty()
            .toHiveModelList(entity.americanmarket),
      );

  List<WorldMarketHiveModel> toHiveModelList(
      List<WorldMarketHiveModel> entity) {
    return entity;
  }
}
