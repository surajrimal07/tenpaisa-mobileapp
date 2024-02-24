// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortterm_interest_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortTermInterestHiveModelAdapter
    extends TypeAdapter<ShortTermInterestHiveModel> {
  @override
  final int typeId = 28;

  @override
  ShortTermInterestHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShortTermInterestHiveModel(
      values: (fields[0] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ShortTermInterestHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortTermInterestHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
