// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topgainers_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopGainersHiveModelAdapter extends TypeAdapter<TopGainersHiveModel> {
  @override
  final int typeId = 14;

  @override
  TopGainersHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopGainersHiveModel(
      topGainersId: fields[0] as String?,
      symbol: fields[1] as String,
      name: fields[2] as String,
      ltp: fields[3] as double,
      pointchange: fields[4] as double,
      percentchange: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TopGainersHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.topGainersId)
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
      other is TopGainersHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
