import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/topgaines_entity.dart';

part 'topgainers_remote_model.g.dart';

@JsonSerializable()
class TopGainersRemoteModel {
  final String symbol;
  final String name;
  final double ltp;
  final double pointchange;
  final double percentchange;

  TopGainersRemoteModel({
    required this.symbol,
    required this.name,
    required this.ltp,
    required this.pointchange,
    required this.percentchange,
  });

  factory TopGainersRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$TopGainersRemoteModelFromJson(json);
  }

  TopGainersEntity toEntity() {
    return TopGainersEntity(
      symbol: symbol,
      name: name,
      ltp: ltp,
      pointchange: pointchange,
      percentchange: percentchange,
    );
  }
}
