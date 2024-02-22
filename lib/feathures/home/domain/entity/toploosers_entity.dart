import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'toploosers_entity.g.dart';

final topLoosersProvider = StateProvider<TopLoosersEntity>((ref) {
  return const TopLoosersEntity(
    symbol: 'Null',
    name: 'Null',
    ltp: 0.0,
    pointchange: 0.0,
    percentchange: 0.0,
  );
});

@JsonSerializable()
class TopLoosersEntity extends Equatable {
  final String symbol;
  final String name;
  final double ltp;
  final double pointchange;
  final double percentchange;

  const TopLoosersEntity({
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

  factory TopLoosersEntity.fromJson(Map<String, dynamic> json) =>
      _$TopLoosersEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TopLoosersEntityToJson(this);

  TopLoosersEntity toEntity() => TopLoosersEntity(
        symbol: symbol,
        name: name,
        ltp: ltp,
        pointchange: pointchange,
        percentchange: percentchange,
      );
}
