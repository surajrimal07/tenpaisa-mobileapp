import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topgaines_entity.g.dart';

final topGainersProvider = StateProvider<TopGainersEntity>((ref) {
  return const TopGainersEntity(
    symbol: 'Null',
    name: 'Null',
    ltp: 0.0,
    pointchange: 0.0,
    percentchange: 0.0,
  );
});

@JsonSerializable()
class TopGainersEntity extends Equatable {
  final String symbol;
  final String name;
  final double ltp;
  final double pointchange;
  final double percentchange;

  const TopGainersEntity({
    required this.symbol,
    required this.name,
    required this.ltp,
    required this.pointchange,
    required this.percentchange,
  });

  @override
  List<Object?> get props => [
        symbol,
        name,
        ltp,
        pointchange,
        percentchange,
      ];

  factory TopGainersEntity.fromJson(Map<String, dynamic> json) =>
      _$TopGainersEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TopGainersEntityToJson(this);

  TopGainersEntity toEntity() => TopGainersEntity(
        symbol: symbol,
        name: name,
        ltp: ltp,
        pointchange: pointchange,
        percentchange: percentchange,
      );
}
