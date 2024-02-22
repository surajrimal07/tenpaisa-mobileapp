import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/topturnover_entity.dart';

part 'topturnover_remote_model.g.dart';

@JsonSerializable()
class TopTurnoverRemoteModel {
  final String symbol;
  final String name;
  final double turnover;
  final double ltp;

  TopTurnoverRemoteModel({
    required this.symbol,
    required this.name,
    required this.turnover,
    required this.ltp,
  });

  factory TopTurnoverRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$TopTurnoverRemoteModelFromJson(json);
  }

  TopTurnoverEntity toEntity() {
    return TopTurnoverEntity(
      symbol: symbol,
      name: name,
      turnover: turnover,
      ltp: ltp,
    );
  }
}
