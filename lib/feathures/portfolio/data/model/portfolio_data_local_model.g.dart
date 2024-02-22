// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_data_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PortfolioDataHiveModelAdapter
    extends TypeAdapter<PortfolioDataHiveModel> {
  @override
  final int typeId = 26;

  @override
  PortfolioDataHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioDataHiveModel(
      totalPortfolioCost: fields[1] as num,
      totalPortfolioValue: fields[2] as num,
      totalPortfolioReturns: fields[3] as num,
      totalPortfolioReturnsPercentage: fields[4] as double,
      portfolioCount: fields[5] as int,
      averagePortfolioReturns: fields[6] as double,
      averagePortfolioReturnsPercentage: fields[7] as double,
      profitablePortfolios: fields[8] as int,
      unprofitablePortfolios: fields[9] as int,
      recommendation: fields[10] as String,
      totalStocks: fields[11] as int,
      totalUnits: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioDataHiveModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.totalPortfolioCost)
      ..writeByte(2)
      ..write(obj.totalPortfolioValue)
      ..writeByte(3)
      ..write(obj.totalPortfolioReturns)
      ..writeByte(4)
      ..write(obj.totalPortfolioReturnsPercentage)
      ..writeByte(5)
      ..write(obj.portfolioCount)
      ..writeByte(6)
      ..write(obj.averagePortfolioReturns)
      ..writeByte(7)
      ..write(obj.averagePortfolioReturnsPercentage)
      ..writeByte(8)
      ..write(obj.profitablePortfolios)
      ..writeByte(9)
      ..write(obj.unprofitablePortfolios)
      ..writeByte(10)
      ..write(obj.recommendation)
      ..writeByte(11)
      ..write(obj.totalStocks)
      ..writeByte(12)
      ..write(obj.totalUnits);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioDataHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
