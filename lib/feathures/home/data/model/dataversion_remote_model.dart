import 'package:json_annotation/json_annotation.dart';

part 'dataversion_remote_model.g.dart';

@JsonSerializable()
class DataVersionModel {
  final int versionCode;
  final String timestamp;

  DataVersionModel({
    required this.versionCode,
    required this.timestamp,
  });

  factory DataVersionModel.fromJson(Map<String, dynamic> json) {
    return _$DataVersionModelFromJson(json);
  }
}
