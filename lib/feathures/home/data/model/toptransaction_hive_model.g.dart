// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toptransaction_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopTransactionHiveModelAdapter
    extends TypeAdapter<TopTransactionHiveModel> {
  @override
  final int typeId = 16;

  @override
  TopTransactionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopTransactionHiveModel(
      topTransactionId: fields[0] as String?,
      symbol: fields[1] as String,
      name: fields[2] as String,
      transactions: fields[3] as int,
      ltp: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TopTransactionHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.topTransactionId)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.transactions)
      ..writeByte(4)
      ..write(obj.ltp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopTransactionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
