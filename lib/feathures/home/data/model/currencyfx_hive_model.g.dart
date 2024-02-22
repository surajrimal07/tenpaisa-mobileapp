// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currencyfx_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyfxHiveModelAdapter extends TypeAdapter<CurrencyfxHiveModel> {
  @override
  final int typeId = 11;

  @override
  CurrencyfxHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyfxHiveModel(
      currency: fields[0] as String,
      rate: fields[1] as num,
      change: fields[2] as num,
      changepercentage: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyfxHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.rate)
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
      other is CurrencyfxHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
