// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'globalmarket_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GlobalMarketHiveModelAdapter extends TypeAdapter<GlobalMarketHiveModel> {
  @override
  final int typeId = 12;

  @override
  GlobalMarketHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlobalMarketHiveModel(
      index: fields[0] as String,
      quote: fields[1] as num,
      change: fields[2] as num,
      changepercentage: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, GlobalMarketHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.quote)
      ..writeByte(2)
      ..write(obj.change)
      ..writeByte(3)
      ..write(obj.changepercentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalMarketHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
