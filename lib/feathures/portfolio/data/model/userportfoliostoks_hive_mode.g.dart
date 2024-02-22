// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userportfoliostoks_hive_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPortfolioStockHiveModelAdapter
    extends TypeAdapter<UserPortfolioStockHiveModel> {
  @override
  final int typeId = 8;

  @override
  UserPortfolioStockHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPortfolioStockHiveModel(
      id: fields[0] as String?,
      symbol: fields[1] as String,
      quantity: fields[2] as int,
      wacc: fields[3] as double,
      currentprice: fields[4] as double,
      name: fields[5] as String,
      ltp: fields[6] as double,
      costprice: fields[7] as double,
      netgainloss: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserPortfolioStockHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.wacc)
      ..writeByte(4)
      ..write(obj.currentprice)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.ltp)
      ..writeByte(7)
      ..write(obj.costprice)
      ..writeByte(8)
      ..write(obj.netgainloss);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPortfolioStockHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
