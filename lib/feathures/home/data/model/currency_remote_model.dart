import 'package:paisa/feathures/home/domain/entity/currency_entity.dart';

class CurrencyData {
  String name;
  int unit;
  num buy;
  num sell;

  CurrencyData({
    required this.name,
    required this.unit,
    required this.buy,
    required this.sell,
  });

  CurrencyEntity toEntity() => CurrencyEntity(
        name: name,
        unit: unit,
        buy: buy,
        sell: sell,
      );

  factory CurrencyData.fromJson(String name, Map<String, dynamic> json) {
    return CurrencyData(
      name: name,
      unit: json['unit'] as int,
      buy: json['buy'] as num,
      sell: json['sell'] as num,
    );
  }
}
