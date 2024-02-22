// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lossgainrecord_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LossGainRecordsEntity _$LossGainRecordsEntityFromJson(
        Map<String, dynamic> json) =>
    LossGainRecordsEntity(
      id: json['id'] as String,
      date: json['date'] as String,
      value: json['value'] as int,
      portgainloss: json['portgainloss'] as num,
    );

Map<String, dynamic> _$LossGainRecordsEntityToJson(
        LossGainRecordsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'value': instance.value,
      'portgainloss': instance.portgainloss,
    };
