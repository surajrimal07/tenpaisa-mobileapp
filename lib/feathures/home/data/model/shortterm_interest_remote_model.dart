import 'package:paisa/feathures/home/domain/entity/shortterm_entity.dart';

class ShortTermInterestRemoteModel {
  final Map<String, String> values;

  ShortTermInterestRemoteModel({
    required this.values,
  });

  factory ShortTermInterestRemoteModel.fromJson(Map<String, dynamic> json) {
    return ShortTermInterestRemoteModel(
      values: Map<String, String>.from(json['values']),
    );
  }
  ShortTermInterestEntity toEntity() {
    return ShortTermInterestEntity(
      values: values,
    );
  }
}
