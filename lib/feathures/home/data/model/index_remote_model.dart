import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';

part 'index_remote_model.g.dart';

final indexRemoteModelProvider = Provider<IndexRemoteModel>((ref) {
  return IndexRemoteModel(
      date: '',
      index: 0.0,
      percentageChange: 0.0,
      pointChange: 0.0,
      turnover: 0,
      marketStatus: '');
});

@JsonSerializable()
class IndexRemoteModel {
  final String date;
  final double index;
  final double percentageChange;
  final double? pointChange;
  final int? turnover;
  final String? marketStatus;

  IndexRemoteModel(
      {required this.date,
      required this.index,
      required this.percentageChange,
      this.pointChange,
      this.turnover,
      this.marketStatus});

  factory IndexRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$IndexRemoteModelFromJson(json);

  IndexEntity toEntity() => IndexEntity(
      date: date,
      index: index,
      percentageChange: percentageChange,
      pointChange: pointChange,
      turnover: turnover,
      marketStatus: marketStatus);
  List<IndexEntity> toEntityList(List<IndexRemoteModel> remoteModelList) =>
      remoteModelList.map((e) => toEntityFromRemoteModel(e)).toList();

  IndexEntity toEntityFromRemoteModel(IndexRemoteModel remoteModel) =>
      IndexEntity(
          date: remoteModel.date,
          index: remoteModel.index,
          percentageChange: remoteModel.percentageChange,
          pointChange: remoteModel.pointChange,
          turnover: remoteModel.turnover,
          marketStatus: remoteModel.marketStatus);
}
