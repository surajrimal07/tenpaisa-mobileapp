import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'index_entity.g.dart';

final indexEntityProvider = StateProvider<IndexEntity>((ref) =>
    const IndexEntity(
        date: '',
        index: 0.0,
        percentageChange: 0.0,
        pointChange: 0.0,
        turnover: 0,
        marketStatus: ''));

@JsonSerializable()
class IndexEntity extends Equatable {
  final String date;
  final num index; //changed to num
  final num percentageChange;
  final num? pointChange;
  final int? turnover;
  final String? marketStatus;

  const IndexEntity(
      {required this.date,
      required this.index,
      required this.percentageChange,
      this.pointChange,
      this.turnover,
      this.marketStatus});

  factory IndexEntity.fromJson(Map<String, dynamic> json) =>
      _$IndexEntityFromJson(json);

  Map<String, dynamic> toJson() => _$IndexEntityToJson(this);

  IndexEntity toEntity() => IndexEntity(
      date: date,
      index: index,
      percentageChange: percentageChange,
      pointChange: pointChange,
      turnover: turnover,
      marketStatus: marketStatus);

  @override
  List<Object?> get props =>
      [date, index, percentageChange, pointChange, turnover, marketStatus];
}
