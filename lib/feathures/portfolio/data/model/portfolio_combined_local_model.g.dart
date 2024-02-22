// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_combined_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PortfolioLocalCombinedModelAdapter
    extends TypeAdapter<PortfolioLocalCombinedModel> {
  @override
  final int typeId = 27;

  @override
  PortfolioLocalCombinedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PortfolioLocalCombinedModel(
      portfolioDataHiveModel: fields[0] as PortfolioDataHiveModel,
      portfolioHiveModelList: (fields[1] as List).cast<PortfolioHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PortfolioLocalCombinedModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.portfolioDataHiveModel)
      ..writeByte(1)
      ..write(obj.portfolioHiveModelList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioLocalCombinedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
