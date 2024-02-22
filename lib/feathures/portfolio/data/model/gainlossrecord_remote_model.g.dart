// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gainlossrecord_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GainLossRecord _$GainLossRecordFromJson(Map<String, dynamic> json) =>
    GainLossRecord(
      id: json['_id'] as String,
      date: json['date'] as String,
      value: json['value'] as int,
      portgainloss: json['portgainloss'] as num,
    );

Map<String, dynamic> _$GainLossRecordToJson(GainLossRecord instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'date': instance.date,
      'value': instance.value,
      'portgainloss': instance.portgainloss,
    };
