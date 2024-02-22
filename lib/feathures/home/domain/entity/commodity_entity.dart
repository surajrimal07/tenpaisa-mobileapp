import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commodity_entity.g.dart';

final commodityEntityProvider = StateProvider<CommodityEntity>((ref) {
  return const CommodityEntity(
    unit: 'Null',
    id: 'Null',
    symbol: 'Null',
    name: 'Null',
    category: 'Null',
    ltp: 0,
  );
});

@JsonSerializable()
class CommodityEntity extends Equatable {
  final String unit;
  final String? id;
  final String? symbol;
  final String name;
  final String category;
  final double ltp;

  const CommodityEntity({
    required this.unit,
    this.id,
    this.symbol,
    required this.name,
    required this.category,
    required this.ltp,
  });

  @override
  List<Object?> get props => [
        unit,
        id,
        symbol,
        name,
        category,
        ltp,
      ];

  factory CommodityEntity.fromJson(Map<String, dynamic> json) =>
      _$CommodityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CommodityEntityToJson(this);

  CommodityEntity toEntity() => CommodityEntity(
        unit: unit,
        id: id,
        symbol: symbol,
        name: name,
        category: category,
        ltp: ltp,
      );
}
