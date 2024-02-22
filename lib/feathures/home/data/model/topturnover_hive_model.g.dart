// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topturnover_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopTurnoverHiveModelAdapter extends TypeAdapter<TopTurnoverHiveModel> {
  @override
  final int typeId = 17;

  @override
  TopTurnoverHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopTurnoverHiveModel(
      topTurnoverId: fields[0] as String?,
      symbol: fields[1] as String,
      name: fields[2] as String,
      turnover: fields[3] as double,
      ltp: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TopTurnoverHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.topTurnoverId)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.turnover)
      ..writeByte(4)
      ..write(obj.ltp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopTurnoverHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
