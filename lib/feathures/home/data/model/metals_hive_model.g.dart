// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metals_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetalsHiveModelAdapter extends TypeAdapter<MetalsHiveModel> {
  @override
  final int typeId = 22;

  @override
  MetalsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetalsHiveModel(
      metalId: fields[0] as String?,
      unit: fields[1] as String,
      id: fields[2] as String,
      symbol: fields[3] as String,
      name: fields[4] as String,
      category: fields[5] as String,
      sector: fields[6] as String,
      ltp: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MetalsHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.metalId)
      ..writeByte(1)
      ..write(obj.unit)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.symbol)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.sector)
      ..writeByte(7)
      ..write(obj.ltp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetalsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
