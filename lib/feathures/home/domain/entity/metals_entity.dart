import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metals_entity.g.dart';

final metalsEntityProvider = StateProvider<MetalsEnity>((ref) {
  return const MetalsEnity(
    unit: 'Null',
    id: 'Null',
    symbol: 'Null',
    name: 'Null',
    category: 'Null',
    sector: 'Null',
    ltp: 0.0,
  );
});

@JsonSerializable()
class MetalsEnity extends Equatable {
  final String unit;
  final String id;
  final String symbol;
  final String name;
  final String category;
  final String sector;
  final double ltp;

  const MetalsEnity({
    required this.unit,
    required this.id,
    required this.symbol,
    required this.name,
    required this.category,
    required this.sector,
    required this.ltp,
  });

  @override
  List<Object?> get props => [
        unit,
        id,
        symbol,
        name,
        category,
        sector,
        ltp,
      ];

  factory MetalsEnity.fromJson(Map<String, dynamic> json) =>
      _$MetalsEnityFromJson(json);

  Map<String, dynamic> toJson() => _$MetalsEnityToJson(this);

  MetalsEnity toEntity() => MetalsEnity(
        unit: unit,
        id: id,
        symbol: symbol,
        name: name,
        category: category,
        sector: sector,
        ltp: ltp,
      );
}
