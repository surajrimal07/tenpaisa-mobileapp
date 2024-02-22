import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_market_entity.g.dart';

final globalMarketEntityProvider = StateProvider<GlobalMarketEntity>((ref) {
  return const GlobalMarketEntity(
      index: 'Null', quote: 0.0, change: 0.0, changepercentage: 0.0);
});

@JsonSerializable()
class GlobalMarketEntity extends Equatable {
  final String index;
  final num quote;
  final num change;
  final num changepercentage;

  const GlobalMarketEntity(
      {required this.index,
      required this.quote,
      required this.change,
      required this.changepercentage});

  @override
  List<Object?> get props => [index, quote, change, changepercentage];

  factory GlobalMarketEntity.fromJson(Map<String, dynamic> json) =>
      _$GlobalMarketEntityFromJson(json);

  GlobalMarketEntity toEntity() => GlobalMarketEntity(
      index: index,
      quote: quote,
      change: change,
      changepercentage: changepercentage);
}
