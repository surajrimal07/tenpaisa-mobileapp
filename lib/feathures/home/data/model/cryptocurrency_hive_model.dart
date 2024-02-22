import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/home/data/model/cryptocurrency_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/crypto_entity.dart';

part 'cryptocurrency_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.cryptoTableId)
class CryptoCurrencyHiveModel {
  @HiveField(0)
  String symbol;
  @HiveField(1)
  String currency;
  @HiveField(2)
  num rate;
  @HiveField(3)
  num change;

  CryptoCurrencyHiveModel({
    required this.symbol,
    required this.currency,
    required this.rate,
    required this.change,
  });

  factory CryptoCurrencyHiveModel.toHiveModel(CryptocurrencyRemoteModel model) {
    return CryptoCurrencyHiveModel(
      symbol: model.symbol,
      currency: model.currency,
      rate: model.rate,
      change: model.change,
    );
  }

  CryptoCurrencyHiveModel.empty()
      : change = 0,
        rate = 0,
        currency = '',
        symbol = '';

  CryptoEntity toEntity() => CryptoEntity(
      symbol: symbol, currency: currency, rate: rate, change: change);

  CryptoCurrencyHiveModel fromEntity(CryptoEntity entity) {
    return CryptoCurrencyHiveModel(
      symbol: entity.symbol,
      currency: entity.currency,
      rate: entity.rate,
      change: entity.change,
    );
  }

  CryptoCurrencyHiveModel toHiveModel(CryptoEntity entity) {
    return CryptoCurrencyHiveModel(
      symbol: entity.symbol,
      currency: entity.currency,
      rate: entity.rate,
      change: entity.change,
    );
  }

  List<CryptoCurrencyHiveModel> toHiveModelList(List<CryptoEntity> entity) {
    return entity
        .map((e) => CryptoCurrencyHiveModel(
              symbol: e.symbol,
              currency: e.currency,
              rate: e.rate,
              change: e.change,
            ))
        .toList();
  }

  List<CryptoEntity> toEntityList(List<CryptoCurrencyHiveModel> entity) {
    return entity
        .map((e) => CryptoEntity(
              symbol: e.symbol,
              currency: e.currency,
              rate: e.rate,
              change: e.change,
            ))
        .toList();
  }
}
