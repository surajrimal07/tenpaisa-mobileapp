import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topturnover_entity.g.dart';

final topTurnoverProvider = StateProvider<TopTurnoverEntity>((ref) {
  return const TopTurnoverEntity(symbol: '', name: '', ltp: 0, turnover: 0);
});

@JsonSerializable()
class TopTurnoverEntity extends Equatable {
  final String symbol;
  final String name;
  final double turnover;
  final double ltp;

  const TopTurnoverEntity(
      {required this.symbol,
      required this.name,
      required this.ltp,
      required this.turnover});

  @override
  List<Object?> get props => [symbol, name, ltp, turnover];

  factory TopTurnoverEntity.fromJson(Map<String, dynamic> json) =>
      _$TopTurnoverEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TopTurnoverEntityToJson(this);

  TopTurnoverEntity toEntity() => TopTurnoverEntity(
        symbol: symbol,
        name: name,
        ltp: ltp,
        turnover: turnover,
      );
}
