import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/crypto_entity.dart';
import 'package:paisa/feathures/home/domain/entity/currencyfx_entity.dart';
import 'package:paisa/feathures/home/domain/entity/global_market_entity.dart';

part 'world_market_entity.g.dart';

final worldMarketEntityProvider = StateProvider((ref) {
  return const WorldMarketEntity(
    cryptocurrency: [],
    forex: [],
    asianmarket: [],
    europeanMarket: [],
    americanmarket: [],
  );
});

@JsonSerializable()
class WorldMarketEntity extends Equatable {
  final List<CryptoEntity> cryptocurrency;
  final List<CurrencyFxEntity> forex;
  final List<GlobalMarketEntity> asianmarket;
  final List<GlobalMarketEntity> europeanMarket;
  final List<GlobalMarketEntity> americanmarket;

  const WorldMarketEntity({
    required this.cryptocurrency,
    required this.forex,
    required this.asianmarket,
    required this.europeanMarket,
    required this.americanmarket,
  });

  @override
  List<Object?> get props => [
        cryptocurrency,
        forex,
        asianmarket,
        europeanMarket,
        americanmarket,
      ];

  WorldMarketEntity toEntity() => WorldMarketEntity(
        cryptocurrency: cryptocurrency,
        forex: forex,
        asianmarket: asianmarket,
        europeanMarket: europeanMarket,
        americanmarket: americanmarket,
      );

  static const dummy = WorldMarketEntity(
    cryptocurrency: [],
    forex: [],
    asianmarket: [],
    europeanMarket: [],
    americanmarket: [],
  );

  factory WorldMarketEntity.fromJson(Map<String, dynamic> json) =>
      _$WorldMarketEntityFromJson(json);
}
