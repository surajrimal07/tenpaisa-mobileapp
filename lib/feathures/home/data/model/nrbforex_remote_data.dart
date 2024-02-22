import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/data/model/currency_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/nrbforex_entity.dart';

final nrbForexRemoteDataProvider = Provider<NrbForexRemoteData>((ref) {
  return NrbForexRemoteData(
    currencyData: [],
  );
});

class NrbForexRemoteData {
  final List<CurrencyData> currencyData;

  NrbForexRemoteData({
    required this.currencyData,
  });

  NrbForexEntity toEntity() => NrbForexEntity(
        currencyData: currencyData.map((item) => item.toEntity()).toList(),
      );

  factory NrbForexRemoteData.fromJson(Map<String, dynamic> json) {
    var currencyData = json.entries.map((entry) {
      return CurrencyData.fromJson(
          entry.key, entry.value as Map<String, dynamic>);
    }).toList();

    return NrbForexRemoteData(
      currencyData: currencyData,
    );
  }
}
