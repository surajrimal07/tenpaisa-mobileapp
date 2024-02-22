import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';

part 'commodity_remote_model.g.dart';

final commodityRemoteModelProvider = Provider<CommodityRemoteModel>((ref) {
  return CommodityRemoteModel(
    unit: '',
    symbol: '',
    name: '',
    category: '',
    ltp: 0.0,
  );
});

@JsonSerializable()
class CommodityRemoteModel {
  final String unit;
  @JsonKey(name: '_id')
  final String? id;
  final String? symbol;
  final String name;
  final String category;
  final double ltp;

  CommodityRemoteModel({
    required this.unit,
     this.id,
    this.symbol,
    required this.name,
    required this.category,
    required this.ltp,
  });

  factory CommodityRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$CommodityRemoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommodityRemoteModelToJson(this);

  CommodityEntity toEntity() => CommodityEntity(
        unit: unit,
        id: id,
        symbol: symbol,
        name: name,
        category: category,
        ltp: ltp,
      );
  List<CommodityEntity> toEntityList(List<CommodityRemoteModel> list) =>
      list.map((item) => item.toEntity()).toList();



}
