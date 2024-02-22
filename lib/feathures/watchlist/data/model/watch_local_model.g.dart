// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchListLocalModelAdapter extends TypeAdapter<WatchListLocalModel> {
  @override
  final int typeId = 5;

  @override
  WatchListLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchListLocalModel(
      id: fields[0] as String,
      user: fields[1] as String,
      name: fields[2] as String,
      stocks: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, WatchListLocalModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.stocks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchListLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
