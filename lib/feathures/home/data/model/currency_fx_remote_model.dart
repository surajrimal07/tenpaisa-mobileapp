import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/currencyfx_entity.dart';

part 'currency_fx_remote_model.g.dart';

@JsonSerializable()
class CurrencyFxRemoteModel {
  final String currency;
  final num rate;
  final num change;
  final num changepercentage;

  CurrencyFxRemoteModel({
    required this.currency,
    required this.rate,
    required this.change,
    required this.changepercentage
  });

  factory CurrencyFxRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$CurrencyFxRemoteModelFromJson(json);
  }

  CurrencyFxEntity toEntity() {
    return CurrencyFxEntity(
      currency: currency,
      rate: rate,
      change: change,
      changepercentage: changepercentage
    );
  }
}
