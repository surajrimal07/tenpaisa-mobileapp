// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toploosers_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopLoosersHiveModelAdapter extends TypeAdapter<TopLoosersHiveModel> {
  @override
  final int typeId = 15;

  @override
  TopLoosersHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopLoosersHiveModel(
      topLoosersId: fields[0] as String?,
      symbol: fields[1] as String,
      name: fields[2] as String,
      ltp: fields[3] as double,
      pointchange: fields[4] as double,
      percentchange: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TopLoosersHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.topLoosersId)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.ltp)
      ..writeByte(4)
      ..write(obj.pointchange)
      ..writeByte(5)
      ..write(obj.percentchange);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopLoosersHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
