import 'package:equatable/equatable.dart';

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
}
