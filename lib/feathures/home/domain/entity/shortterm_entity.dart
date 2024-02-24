import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shortterm_entity.g.dart';

@JsonSerializable()
class ShortTermInterestEntity extends Equatable {
  final Map<String, String> values;

  const ShortTermInterestEntity({
    required this.values,
  });

  factory ShortTermInterestEntity.fromJson(Map<String, dynamic> json) {
    return ShortTermInterestEntity(
      values: Map<String, String>.from(json['values']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'values': values,
    };
  }

  ShortTermInterestEntity toEntity() => ShortTermInterestEntity(
        values: values,
      );

  @override
  List<Object?> get props => [values];
}
