import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/home/domain/entity/accelerometer_entity.dart';

part 'accelerometer_model.g.dart';

@JsonSerializable()
class AccelerometerModel {
  final double x;
  final double y;
  final double z;

  AccelerometerModel({
    required this.x,
    required this.y,
    required this.z,
  });

  AccelerometerEntity toEntity() => AccelerometerEntity(
        x: x,
        y: y,
        z: z,
      );
}
