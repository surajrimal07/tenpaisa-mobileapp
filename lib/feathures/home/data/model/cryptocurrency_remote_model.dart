import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/crypto_entity.dart';

part 'cryptocurrency_remote_model.g.dart';

@JsonSerializable()
class CryptocurrencyRemoteModel {
  final String symbol;
  final String currency;
  final num rate;
  final num change;

  CryptocurrencyRemoteModel({
    required this.symbol,
    required this.currency,
    required this.rate,
    required this.change,
  });

  factory CryptocurrencyRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$CryptocurrencyRemoteModelFromJson(json);
  }

  CryptoEntity toEntity() {
    return CryptoEntity(
      symbol: symbol,
      currency: currency,
      rate: rate,
      change: change,
    );
  }
}
