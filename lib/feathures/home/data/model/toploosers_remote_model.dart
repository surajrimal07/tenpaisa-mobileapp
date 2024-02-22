import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/toploosers_entity.dart';

part 'toploosers_remote_model.g.dart';

@JsonSerializable()
class TopLoosersRemoteModel {
  final String symbol;
  final String name;
  final double ltp;
  final double pointchange;
  final double percentchange;

  TopLoosersRemoteModel({
    required this.symbol,
    required this.name,
    required this.ltp,
    required this.pointchange,
    required this.percentchange,
  });

  factory TopLoosersRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$TopLoosersRemoteModelFromJson(json);
  }
  
  TopLoosersEntity toEntity() {
    return TopLoosersEntity(
      symbol: symbol,
      name: name,
      ltp: ltp,
      pointchange: pointchange,
      percentchange: percentchange,
    );
  }
}
