import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currencyfx_entity.g.dart';

final currencyFxEntityProvider = StateProvider<CurrencyFxEntity>(
  (ref) => const CurrencyFxEntity(
    currency: 'Null',
    rate: 0.0,
    change: 0.0,
    changepercentage: 0.0,
  ),
);

@JsonSerializable()
class CurrencyFxEntity extends Equatable {
  final String currency;
  final num rate;
  final num change;
  final num changepercentage;

  const CurrencyFxEntity(
      {required this.currency,
      required this.rate,
      required this.change,
      required this.changepercentage});

  @override
  List<Object?> get props => [currency, rate, change, changepercentage];

  factory CurrencyFxEntity.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFxEntityFromJson(json);

  CurrencyFxEntity toEntity() => CurrencyFxEntity(
      currency: currency,
      rate: rate,
      change: change,
      changepercentage: changepercentage);
}
