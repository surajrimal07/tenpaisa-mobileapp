import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lossgainrecord_entity.g.dart';

@JsonSerializable()
class LossGainRecordsEntity extends Equatable {
  final String id;
  final String date;
  final int value;
  final num portgainloss;

  const LossGainRecordsEntity({
    required this.id,
    required this.date,
    required this.value,
    required this.portgainloss,
  });

  factory LossGainRecordsEntity.dummy() {
    return const LossGainRecordsEntity(
      id: "Empty",
      date: "Empty",
      value: 0,
      portgainloss: 0,
    );
  }

  factory LossGainRecordsEntity.fromJson(Map<String, dynamic> json) =>
      _$LossGainRecordsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LossGainRecordsEntityToJson(this);

  @override
  List<Object?> get props {
    return [id, date, value, portgainloss];
  }
}
