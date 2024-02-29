// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'world_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldMarketRemoteDto _$WorldMarketRemoteDtoFromJson(
        Map<String, dynamic> json) =>
    WorldMarketRemoteDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data:
          WorldMarketRemoteModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorldMarketRemoteDtoToJson(
        WorldMarketRemoteDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
