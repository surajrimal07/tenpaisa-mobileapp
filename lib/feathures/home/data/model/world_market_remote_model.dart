import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/data/model/cryptocurrency_remote_model.dart';
import 'package:paisa/feathures/home/data/model/currency_fx_remote_model.dart';
import 'package:paisa/feathures/home/data/model/global_market_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';

part 'world_market_remote_model.g.dart';

final worldMarketRemoteModelProvider = Provider<WorldMarketRemoteModel>((ref) {
  return WorldMarketRemoteModel(
    cryptocurrency: [],
    currencyExchangeRates: [],
    asianMarketIndices: [],
    europeanMarketIndices: [],
    americanMarketIndices: [],
  );
});

@JsonSerializable()
class WorldMarketRemoteModel {
  final List<CryptocurrencyRemoteModel> cryptocurrency;
  final List<CurrencyFxRemoteModel> currencyExchangeRates;
  final List<GlobalMarketRemoteModel> asianMarketIndices;
  final List<GlobalMarketRemoteModel> europeanMarketIndices;
  final List<GlobalMarketRemoteModel> americanMarketIndices;

  WorldMarketRemoteModel(
      {required this.cryptocurrency,
      required this.currencyExchangeRates,
      required this.asianMarketIndices,
      required this.europeanMarketIndices,
      required this.americanMarketIndices});

  factory WorldMarketRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$WorldMarketRemoteModelFromJson(json);
  }

  WorldMarketEntity toEntity() => WorldMarketEntity(
        cryptocurrency: cryptocurrency.map((e) => e.toEntity()).toList(),
        forex: currencyExchangeRates.map((e) => e.toEntity()).toList(),
        asianmarket: asianMarketIndices.map((e) => e.toEntity()).toList(),
        europeanMarket: europeanMarketIndices.map((e) => e.toEntity()).toList(),
        americanmarket: americanMarketIndices.map((e) => e.toEntity()).toList(),
      );
}
