// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexDTO _$IndexDTOFromJson(Map<String, dynamic> json) => IndexDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => IndexRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IndexDTOToJson(IndexDTO instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
