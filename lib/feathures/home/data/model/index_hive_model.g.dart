// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndexHiveModelAdapter extends TypeAdapter<IndexHiveModel> {
  @override
  final int typeId = 20;

  @override
  IndexHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndexHiveModel(
      indexId: fields[0] as String?,
      date: fields[1] as String,
      index: fields[2] as num,
      percentageChange: fields[3] as num,
      pointChange: fields[4] as num?,
      turnover: fields[5] as int?,
      marketStatus: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IndexHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.indexId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.index)
      ..writeByte(3)
      ..write(obj.percentageChange)
      ..writeByte(4)
      ..write(obj.pointChange)
      ..writeByte(5)
      ..write(obj.turnover)
      ..writeByte(6)
      ..write(obj.marketStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndexHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
