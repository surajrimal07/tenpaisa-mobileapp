// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nrb_forex_local_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NrbForexLocalModelAdapter extends TypeAdapter<NrbForexLocalModel> {
  @override
  final int typeId = 25;

  @override
  NrbForexLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NrbForexLocalModel(
      currency: (fields[0] as List).cast<CurrencyLocalModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, NrbForexLocalModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NrbForexLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
