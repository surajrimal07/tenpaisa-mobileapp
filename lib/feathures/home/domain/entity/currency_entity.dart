import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currencyEntityProvider = StateProvider<CurrencyEntity>((ref) {
  return const CurrencyEntity(
    name: '',
    unit: 0,
    buy: 0.0,
    sell: 0.0,
  );
});

class CurrencyEntity extends Equatable {
  final String name;
  final int unit;
  final num buy;
  final num sell;

  @override
  List<Object?> get props => [name, unit, buy, sell];

  const CurrencyEntity({
    required this.name,
    required this.unit,
    required this.buy,
    required this.sell,
  });

  factory CurrencyEntity.fromJson(String name, Map<String, dynamic> json) {
    return CurrencyEntity(
      name: name,
      unit: json['unit'] as int,
      buy: json['buy'] as double,
      sell: json['sell'] as double,
    );
  }
  CurrencyEntity toEntity() => CurrencyEntity(
        name: name,
        unit: unit,
        buy: buy,
        sell: sell,
      );
}
