import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/domain/entity/currency_entity.dart';

final nrbForexEntityProvider = StateProvider<NrbForexEntity>((ref) {
  return const NrbForexEntity(
    currencyData: [
      CurrencyEntity(
        name: '',
        unit: 0,
        buy: 0.0,
        sell: 0.0,
      ),
    ],
  );
});

class NrbForexEntity extends Equatable {
  final List<CurrencyEntity> currencyData;

  @override
  List<Object?> get props => [currencyData];

  const NrbForexEntity({
    required this.currencyData,
  });

  factory NrbForexEntity.fromJson(Map<String, dynamic> json) {
    final List<CurrencyEntity> currencies = [];

    json.forEach((key, value) {
      currencies.add(CurrencyEntity.fromJson(key, value));
    });

    return NrbForexEntity(
      currencyData: currencies,
    );
  }

  NrbForexEntity toEntity() => NrbForexEntity(
        currencyData: currencyData.map((item) => item.toEntity()).toList(),
      );
}
