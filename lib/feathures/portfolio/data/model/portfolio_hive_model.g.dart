// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PortfolioHiveModelAdapter extends TypeAdapter<PortfolioHiveModel> {
  @override
  final int typeId = 2;

  @override
  PortfolioHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioHiveModel(
      id: fields[0] as String,
      userEmail: fields[1] as String,
      name: fields[2] as String,
      stocks: (fields[3] as List?)?.cast<UserPortfolioStockHiveModel>(),
      totalunits: fields[4] as int?,
      gainLossRecords: (fields[5] as List?)?.cast<GainLossRecordHiveModel>(),
      portfoliocost: fields[6] as num?,
      portfoliovalue: fields[7] as num?,
      recommendation: fields[8] as String?,
      percentage: fields[9] as double?,
      portfolioGoal: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userEmail)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.stocks)
      ..writeByte(4)
      ..write(obj.totalunits)
      ..writeByte(5)
      ..write(obj.gainLossRecords)
      ..writeByte(6)
      ..write(obj.portfoliocost)
      ..writeByte(7)
      ..write(obj.portfoliovalue)
      ..writeByte(8)
      ..write(obj.recommendation)
      ..writeByte(9)
      ..write(obj.percentage)
      ..writeByte(10)
      ..write(obj.portfolioGoal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
