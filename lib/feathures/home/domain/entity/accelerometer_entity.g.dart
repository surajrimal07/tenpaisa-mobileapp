// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accelerometer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccelerometerEntity _$AccelerometerEntityFromJson(Map<String, dynamic> json) =>
    AccelerometerEntity(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      z: (json['z'] as num).toDouble(),
    );

Map<String, dynamic> _$AccelerometerEntityToJson(
        AccelerometerEntity instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
    };
