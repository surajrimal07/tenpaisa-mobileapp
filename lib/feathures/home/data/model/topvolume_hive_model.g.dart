// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topvolume_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopVolumeHiveModelAdapter extends TypeAdapter<TopVolumeHiveModel> {
  @override
  final int typeId = 18;

  @override
  TopVolumeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopVolumeHiveModel(
      topVolumeId: fields[0] as String?,
      symbol: fields[1] as String,
      name: fields[2] as String,
      volume: fields[3] as int,
      ltp: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TopVolumeHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.topVolumeId)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.volume)
      ..writeByte(4)
      ..write(obj.ltp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopVolumeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
