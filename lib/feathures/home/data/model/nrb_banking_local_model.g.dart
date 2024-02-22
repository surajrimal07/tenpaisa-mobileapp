// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nrb_banking_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NrbBankingLocalModelAdapter extends TypeAdapter<NrbBankingLocalModel> {
  @override
  final int typeId = 24;

  @override
  NrbBankingLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NrbBankingLocalModel(
      totalDeposits: fields[0] as String,
      commercialBanksTotalDeposits: fields[1] as String,
      otherBfIsTotalDeposits: fields[2] as String,
      totalLending: fields[3] as String,
      commercialBanksTotalLending: fields[4] as String,
      otherBfIsTotalLending: fields[5] as String,
      cdRatio: fields[6] as String,
      interbankInterestRateLcyWeightedAvg: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NrbBankingLocalModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.totalDeposits)
      ..writeByte(1)
      ..write(obj.commercialBanksTotalDeposits)
      ..writeByte(2)
      ..write(obj.otherBfIsTotalDeposits)
      ..writeByte(3)
      ..write(obj.totalLending)
      ..writeByte(4)
      ..write(obj.commercialBanksTotalLending)
      ..writeByte(5)
      ..write(obj.otherBfIsTotalLending)
      ..writeByte(6)
      ..write(obj.cdRatio)
      ..writeByte(7)
      ..write(obj.interbankInterestRateLcyWeightedAvg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NrbBankingLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
