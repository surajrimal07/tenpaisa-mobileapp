// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesHiveModelAdapter extends TypeAdapter<CategoriesHiveModel> {
  @override
  final int typeId = 3;

  @override
  CategoriesHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoriesHiveModel(
      categoriesId: fields[0] as String?,
      topGainers: (fields[1] as List).cast<TopGainersHiveModel>(),
      topLosers: (fields[2] as List).cast<TopLoosersHiveModel>(),
      topVolume: (fields[3] as List).cast<TopVolumeHiveModel>(),
      topTrans: (fields[4] as List).cast<TopTransactionHiveModel>(),
      topTurnover: (fields[5] as List).cast<TopTurnoverHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoriesHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.categoriesId)
      ..writeByte(1)
      ..write(obj.topGainers)
      ..writeByte(2)
      ..write(obj.topLosers)
      ..writeByte(3)
      ..write(obj.topVolume)
      ..writeByte(4)
      ..write(obj.topTrans)
      ..writeByte(5)
      ..write(obj.topTurnover);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
