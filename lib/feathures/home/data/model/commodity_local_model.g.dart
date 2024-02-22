// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommodityLocalHiveModelAdapter
    extends TypeAdapter<CommodityLocalHiveModel> {
  @override
  final int typeId = 21;

  @override
  CommodityLocalHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommodityLocalHiveModel(
      id: fields[0] as String?,
      symbol: fields[1] as String?,
      name: fields[2] as String,
      category: fields[3] as String,
      ltp: fields[4] as double,
      unit: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CommodityLocalHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.ltp)
      ..writeByte(5)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommodityLocalHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
