import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/global_market_entity.dart';

part 'global_market_remote_model.g.dart';

@JsonSerializable()
class GlobalMarketRemoteModel {
  String index;
  num quote;
  num change;
  num changepercentage;

  GlobalMarketRemoteModel(
      {required this.index,
      required this.quote,
      required this.change,
      required this.changepercentage});

  factory GlobalMarketRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$GlobalMarketRemoteModelFromJson(json);
  }

  GlobalMarketEntity toEntity() {
    return GlobalMarketEntity(
        index: index,
        quote: quote,
        change: change,
        changepercentage: changepercentage);
  }
}
