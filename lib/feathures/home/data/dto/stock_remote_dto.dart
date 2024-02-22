import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/data/model/dataversion_remote_model.dart';
import 'package:paisa/feathures/home/data/model/stock_remote_model.dart';

part 'stock_remote_dto.g.dart';

@JsonSerializable()
class StockRemoteDTO {
  final List<StockRemoteModel> data;
  final bool isFallback;
  final bool isCached;
  final DataVersionModel dataversion;

  StockRemoteDTO({
    required this.data,
    required this.isFallback,
    required this.isCached,
    required this.dataversion,
  });

  factory StockRemoteDTO.fromJson(Map<String, dynamic> json) =>
      _$StockRemoteDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StockRemoteDTOToJson(this);
}
