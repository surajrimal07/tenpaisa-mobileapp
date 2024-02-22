import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/data/model/topgainers_remote_model.dart';
import 'package:paisa/feathures/home/data/model/toploosers_remote_model.dart';
import 'package:paisa/feathures/home/data/model/toptransaction_remote_model.dart';
import 'package:paisa/feathures/home/data/model/topturnover_remote_model.dart';
import 'package:paisa/feathures/home/data/model/topvolume_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';

part 'categories_remote_model.g.dart';

final topCategoriesRemoteModelProvider =
    Provider<TopCategoriesRemoteModel>((ref) {
  return TopCategoriesRemoteModel(
    topGainers: [],
    topLoosers: [],
    topTurnover: [],
    topVolume: [],
    topTrans: [],
  );
});

@JsonSerializable()
class TopCategoriesRemoteModel {
  final List<TopGainersRemoteModel> topGainers;
  final List<TopLoosersRemoteModel> topLoosers;
  final List<TopTurnoverRemoteModel> topTurnover;
  final List<TopVolumeRemoteModel> topVolume;
  final List<TopTransactionRemoteModel> topTrans;

  TopCategoriesRemoteModel({
    required this.topGainers,
    required this.topLoosers,
    required this.topTurnover,
    required this.topVolume,
    required this.topTrans,
  });

  TopCategoriesEntity toEntity() => TopCategoriesEntity(
        topGainers: topGainers.map((item) => item.toEntity()).toList(),
        topLoosers: topLoosers.map((item) => item.toEntity()).toList(),
        topTurnover: topTurnover.map((item) => item.toEntity()).toList(),
        topVolume: topVolume.map((item) => item.toEntity()).toList(),
        topTrans: topTrans.map((item) => item.toEntity()).toList(),
      );

  factory TopCategoriesRemoteModel.fromJson(Map<String, dynamic> json) {
    return TopCategoriesRemoteModel(
      topGainers:
          _mapData(json['topGainers']['data'], TopGainersRemoteModel.fromJson),
      topLoosers:
          _mapData(json['topLoosers']['data'], TopLoosersRemoteModel.fromJson),
      topTurnover: _mapData(
          json['topTurnover']['data'], TopTurnoverRemoteModel.fromJson),
      topVolume:
          _mapData(json['topVolume']['data'], TopVolumeRemoteModel.fromJson),
      topTrans: _mapData(
          json['topTrans']['data'], TopTransactionRemoteModel.fromJson),
    );
  }

  static List<T> _mapData<T>(
      dynamic data, T Function(Map<String, dynamic>) fromJson) {
    if (data is List) {
      return data.map((item) => fromJson(item)).toList();
    } else {
      return [];
    }
  }
}
