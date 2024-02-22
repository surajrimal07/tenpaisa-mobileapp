// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_market_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorldMarketHiveModelAdapter extends TypeAdapter<WorldMarketHiveModel> {
  @override
  final int typeId = 13;

  @override
  WorldMarketHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorldMarketHiveModel(
      worldMarketId: fields[0] as String?,
      cryptocurrency: (fields[1] as List).cast<CryptoCurrencyHiveModel>(),
      currencyExchangeRates: (fields[2] as List).cast<CurrencyfxHiveModel>(),
      asianMarketIndices: (fields[3] as List).cast<GlobalMarketHiveModel>(),
      europeanMarketIndices: (fields[4] as List).cast<GlobalMarketHiveModel>(),
      americanMarketIndices: (fields[5] as List).cast<GlobalMarketHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorldMarketHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.worldMarketId)
      ..writeByte(1)
      ..write(obj.cryptocurrency)
      ..writeByte(2)
      ..write(obj.currencyExchangeRates)
      ..writeByte(3)
      ..write(obj.asianMarketIndices)
      ..writeByte(4)
      ..write(obj.europeanMarketIndices)
      ..writeByte(5)
      ..write(obj.americanMarketIndices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorldMarketHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
