// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stocks_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StocksHiveModelAdapter extends TypeAdapter<StocksHiveModel> {
  @override
  final int typeId = 19;

  @override
  StocksHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StocksHiveModel(
      symbolId: fields[0] as String?,
      symbol: fields[1] as String,
      ltp: fields[2] as double,
      pointchange: fields[3] as double,
      percentchange: fields[4] as double,
      name: fields[5] as String,
      high: fields[6] as double,
      low: fields[7] as double,
      sector: fields[18] as String,
      open: fields[8] as double,
      volume: fields[9] as int,
      previousClose: fields[10] as double,
      category: fields[11] as String,
      vwap: fields[12] as int?,
      turnover: fields[13] as int?,
      day120: fields[14] as int?,
      day180: fields[15] as int?,
      week52High: fields[16] as int?,
      week52Low: fields[17] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, StocksHiveModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.symbolId)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.ltp)
      ..writeByte(3)
      ..write(obj.pointchange)
      ..writeByte(4)
      ..write(obj.percentchange)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.high)
      ..writeByte(7)
      ..write(obj.low)
      ..writeByte(8)
      ..write(obj.open)
      ..writeByte(9)
      ..write(obj.volume)
      ..writeByte(10)
      ..write(obj.previousClose)
      ..writeByte(11)
      ..write(obj.category)
      ..writeByte(12)
      ..write(obj.vwap)
      ..writeByte(13)
      ..write(obj.turnover)
      ..writeByte(14)
      ..write(obj.day120)
      ..writeByte(15)
      ..write(obj.day180)
      ..writeByte(16)
      ..write(obj.week52High)
      ..writeByte(17)
      ..write(obj.week52Low)
      ..writeByte(18)
      ..write(obj.sector);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StocksHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
