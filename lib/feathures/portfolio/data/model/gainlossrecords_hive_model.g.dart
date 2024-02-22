// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gainlossrecords_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GainLossRecordHiveModelAdapter
    extends TypeAdapter<GainLossRecordHiveModel> {
  @override
  final int typeId = 9;

  @override
  GainLossRecordHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GainLossRecordHiveModel(
      id: fields[0] as String?,
      date: fields[1] as double,
      value: fields[2] as double,
      portgainloss: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, GainLossRecordHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.portgainloss);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GainLossRecordHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
