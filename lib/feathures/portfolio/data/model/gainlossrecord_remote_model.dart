import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paisa/feathures/portfolio/domain/entity/lossgainrecord_entity.dart';

part 'gainlossrecord_remote_model.g.dart';

final gainLossRecordModeProvider = Provider<GainLossRecord>((ref) {
  return GainLossRecord.dummy();
});

@JsonSerializable()
class GainLossRecord {
  @JsonKey(name: '_id')
  String id;
  String date;
  int value;
  num portgainloss;

  GainLossRecord({
    required this.id,
    required this.date,
    required this.value,
    required this.portgainloss,
  });

  LossGainRecordsEntity toEntity() => LossGainRecordsEntity(
      id: id, date: date, value: value, portgainloss: portgainloss);

  factory GainLossRecord.fromJson(Map<String, dynamic> json) =>
      _$GainLossRecordFromJson(json);

  Map<String, dynamic> toJson() => _$GainLossRecordToJson(this);

  List<LossGainRecordsEntity> toEntityList(List<GainLossRecord> models) =>
      models.map((model) => model.toEntity()).toList();

  GainLossRecord.dummy()
      : id = "Empty",
        date = "Empty",
        value = 0,
        portgainloss = 0;

  @override
  String toString() {
    return 'GainLossRecord(id: $id, date: $date, value: $value, portgainloss: $portgainloss)';
  }
}
