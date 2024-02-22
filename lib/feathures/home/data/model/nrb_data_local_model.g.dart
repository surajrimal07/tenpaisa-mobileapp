// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nrb_data_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NrbDataLocalHiveModelAdapter extends TypeAdapter<NrbDataLocalHiveModel> {
  @override
  final int typeId = 7;

  @override
  NrbDataLocalHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NrbDataLocalHiveModel(
      nrbBankingData: fields[0] as NrbBankingLocalModel,
      nrbForexData: fields[1] as NrbForexLocalModel,
    );
  }

  @override
  void write(BinaryWriter writer, NrbDataLocalHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nrbBankingData)
      ..writeByte(1)
      ..write(obj.nrbForexData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NrbDataLocalHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
