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
      totalDeposits: (fields[0] as Map).cast<String, String>(),
      commercialBanksTotalDeposits: (fields[1] as Map).cast<String, String>(),
      otherBfIsTotalDeposits: (fields[2] as Map).cast<String, String>(),
      totalLending: (fields[3] as Map).cast<String, String>(),
      commercialBanksTotalLending: (fields[4] as Map).cast<String, String>(),
      otherBfIsTotalLending: (fields[5] as Map).cast<String, String>(),
      cdRatio: (fields[6] as Map).cast<String, String>(),
      interbankInterestRateLcyWeightedAvg:
          (fields[7] as Map).cast<String, String>(),
      shortTermInterestRates: fields[8] as ShortTermInterestHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, NrbBankingLocalModel obj) {
    writer
      ..writeByte(9)
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
      ..write(obj.interbankInterestRateLcyWeightedAvg)
      ..writeByte(8)
      ..write(obj.shortTermInterestRates);
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
