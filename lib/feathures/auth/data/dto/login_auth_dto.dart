import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/auth/data/model/auth_remote_model.dart';

part 'login_auth_dto.g.dart';

@JsonSerializable()
class AuthDTO {
  final bool success;
  final String message;
  final AuthRemoteModel data;

  AuthDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AuthDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDTOToJson(this);
}
