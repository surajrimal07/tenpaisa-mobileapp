// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nrb_currency_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyLocalModelAdapter extends TypeAdapter<CurrencyLocalModel> {
  @override
  final int typeId = 23;

  @override
  CurrencyLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyLocalModel(
      name: fields[0] as String,
      unit: fields[1] as int,
      buy: fields[2] as num,
      sell: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyLocalModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.unit)
      ..writeByte(2)
      ..write(obj.buy)
      ..writeByte(3)
      ..write(obj.sell);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
