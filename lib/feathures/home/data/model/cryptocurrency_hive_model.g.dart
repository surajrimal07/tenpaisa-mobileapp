// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptocurrency_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoCurrencyHiveModelAdapter
    extends TypeAdapter<CryptoCurrencyHiveModel> {
  @override
  final int typeId = 10;

  @override
  CryptoCurrencyHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoCurrencyHiveModel(
      symbol: fields[0] as String,
      currency: fields[1] as String,
      rate: fields[2] as num,
      change: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoCurrencyHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.symbol)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.rate)
      ..writeByte(3)
      ..write(obj.change);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCurrencyHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
