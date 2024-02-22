import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accelerometer_entity.g.dart';

@JsonSerializable()
class AccelerometerEntity extends Equatable {
  final double x;
  final double y;
  final double z;

  const AccelerometerEntity({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  List<Object?> get props => [
        x,
        y,
        z,
      ];

  AccelerometerEntity toEntity() => AccelerometerEntity(
        x: x,
        y: y,
        z: z,
      );
}
