import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa/config/constants/hive_table_constants.dart';
import 'package:paisa/feathures/portfolio/domain/entity/lossgainrecord_entity.dart';
import 'package:uuid/uuid.dart';

part 'gainlossrecords_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.gainLossRecordTableId)
class GainLossRecordHiveModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  double date;
  @HiveField(2)
  double value;
  @HiveField(3)
  num portgainloss;

  GainLossRecordHiveModel({
    String? id,
    required this.date,
    required this.value,
    required this.portgainloss,
  }) : id = id ?? const Uuid().v4();

  GainLossRecordHiveModel.empty()
      : this(id: "Empty", date: 0, value: 0, portgainloss: 0);

  LossGainRecordsEntity toEntity() => LossGainRecordsEntity(
        id: id,
        date: date.toString(),
        value: value.toInt(),
        portgainloss: portgainloss,
      );

  GainLossRecordHiveModel fromEntity(LossGainRecordsEntity entity) =>
      GainLossRecordHiveModel(
        id: entity.id,
        date: double.parse(entity.date),
        value: entity.value.toDouble(),
        portgainloss: entity.portgainloss,
      );

  GainLossRecordHiveModel toHiveModel(LossGainRecordsEntity entity) =>
      GainLossRecordHiveModel(
        id: entity.id,
        date: double.parse(entity.date),
        value: entity.value.toDouble(),
        portgainloss: entity.portgainloss,
      );

  List<GainLossRecordHiveModel> toHiveModelList(
          List<LossGainRecordsEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  List<LossGainRecordsEntity> toEntityList(
          List<GainLossRecordHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'GainLossRecordHiveModel{id: $id, date: $date, value: $value, portgainloss: $portgainloss}';
  }
}
