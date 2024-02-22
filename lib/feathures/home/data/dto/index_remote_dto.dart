import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/data/model/index_remote_model.dart';

part 'index_remote_dto.g.dart';

@JsonSerializable()
class IndexDTO {
  final bool success;
  final String message;
  final List<IndexRemoteModel> data;

  IndexDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  factory IndexDTO.fromJson(Map<String, dynamic> json) =>
      _$IndexDTOFromJson(json);
}
