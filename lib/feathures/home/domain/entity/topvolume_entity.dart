import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topvolume_entity.g.dart';

final topVolumeProvider = StateProvider<TopVolumeEntity>((ref) {
  return const TopVolumeEntity(symbol: '', name: '', ltp: 0, volume: 0);
});

@JsonSerializable()
class TopVolumeEntity extends Equatable {
  final String symbol;
  final String name;
  final int volume;
  final double ltp;

  const TopVolumeEntity(
      {required this.symbol,
      required this.name,
      required this.ltp,
      required this.volume});

  @override
  List<Object?> get props => [symbol, name, ltp, volume];

  factory TopVolumeEntity.fromJson(Map<String, dynamic> json) =>
      _$TopVolumeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TopVolumeEntityToJson(this);

  TopVolumeEntity toEntity() => TopVolumeEntity(
        symbol: symbol,
        name: name,
        ltp: ltp,
        volume: volume,
      );
}
