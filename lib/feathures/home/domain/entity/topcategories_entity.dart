// ignore_for_file: override_on_non_overriding_member

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/topgaines_entity.dart';
import 'package:paisa/feathures/home/domain/entity/toploosers_entity.dart';
import 'package:paisa/feathures/home/domain/entity/toptransaction_entity.dart';
import 'package:paisa/feathures/home/domain/entity/topturnover_entity.dart';
import 'package:paisa/feathures/home/domain/entity/topvolume_entity.dart';

part 'topcategories_entity.g.dart';

final categoriesEntityProvider = StateProvider<TopCategoriesEntity>((ref) {
  return const TopCategoriesEntity(
    topGainers: [],
    topLoosers: [],
    topTrans: [],
    topTurnover: [],
    topVolume: [],
  );
});

@JsonSerializable()
class TopCategoriesEntity extends Equatable {
  final List<TopGainersEntity> topGainers;
  final List<TopLoosersEntity> topLoosers;
  final List<TopTransactionEntity> topTrans;
  final List<TopTurnoverEntity> topTurnover;
  final List<TopVolumeEntity> topVolume;

  @override
  List<Object?> get props => [
        topGainers,
        topLoosers,
        topTrans,
        topTurnover,
        topVolume,
      ];

  const TopCategoriesEntity({
    required this.topGainers,
    required this.topLoosers,
    required this.topTurnover,
    required this.topVolume,
    required this.topTrans,
  });

  factory TopCategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$TopCategoriesEntityFromJson(json);

  TopCategoriesEntity toEntity() => TopCategoriesEntity(
        topGainers: topGainers.map((item) => item.toEntity()).toList(),
        topLoosers: topLoosers.map((item) => item.toEntity()).toList(),
        topTurnover: topTurnover.map((item) => item.toEntity()).toList(),
        topVolume: topVolume.map((item) => item.toEntity()).toList(),
        topTrans: topTrans.map((item) => item.toEntity()).toList(),
      );
}
