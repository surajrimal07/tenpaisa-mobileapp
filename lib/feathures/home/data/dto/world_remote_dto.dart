import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/data/model/world_market_remote_model.dart';

part 'world_remote_dto.g.dart';

@JsonSerializable()
class WorldMarketRemoteDto {
  final bool success;
  final String message;
  final WorldMarketRemoteModel data;

  WorldMarketRemoteDto({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WorldMarketRemoteDto.fromJson(Map<String, dynamic> json) {
    return _$WorldMarketRemoteDtoFromJson(json);
  }
}
