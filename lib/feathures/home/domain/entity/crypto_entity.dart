import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_entity.g.dart';

final cryptoEntityProvider = StateProvider<CryptoEntity>(
  (ref) => const CryptoEntity(
    symbol: 'Null',
    currency: 'Null',
    rate: 0.0,
    change: 0.0,
  ),
);

@JsonSerializable()
class CryptoEntity extends Equatable {
  final String symbol;
  final String currency;
  final num rate;
  final num change;

  const CryptoEntity({
    required this.symbol,
    required this.currency,
    required this.rate,
    required this.change,
  });

  @override
  List<Object?> get props => [
        symbol,
        currency,
        rate,
        change,
      ];

  factory CryptoEntity.fromJson(Map<String, dynamic> json) =>
      _$CryptoEntityFromJson(json);

  CryptoEntity toEntity() => CryptoEntity(
        symbol: symbol,
        currency: currency,
        rate: rate,
        change: change,
      );

  static CryptoEntity dummy = const CryptoEntity(
    symbol: 'Null',
    currency: 'Null',
    rate: 0.0,
    change: 0.0,
  );
}
