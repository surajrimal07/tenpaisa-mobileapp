import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/topvolume_entity.dart';

part 'topvolume_remote_model.g.dart';

@JsonSerializable()
class TopVolumeRemoteModel {
  final String symbol;
  final String name;
  final int volume;
  final double ltp;

  TopVolumeRemoteModel({
    required this.symbol,
    required this.name,
    required this.volume,
    required this.ltp,
  });

  factory TopVolumeRemoteModel.fromJson(Map<String, dynamic> json) {
    return _$TopVolumeRemoteModelFromJson(json);
  }

  TopVolumeEntity toEntity() {
    return TopVolumeEntity(
      symbol: symbol,
      name: name,
      ltp: ltp,
      volume: volume,
    );
  }
}
