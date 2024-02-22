import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/data/model/commodity_remote_model.dart';
import 'package:paisa/feathures/home/data/model/dataversion_remote_model.dart';

part 'commodity_remote_dto.g.dart';

@JsonSerializable()
class CommodityDTO {
  final List<CommodityRemoteModel> data;
  final bool isFallback;
  final bool isCached;
  final DataVersionModel dataversion;

  CommodityDTO({
    required this.data,
    required this.isFallback,
    required this.isCached,
    required this.dataversion,
  });

  factory CommodityDTO.fromJson(Map<String, dynamic> json) =>
      _$CommodityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CommodityDTOToJson(this);
}
