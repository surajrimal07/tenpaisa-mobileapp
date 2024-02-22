// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDTO _$AuthDTOFromJson(Map<String, dynamic> json) => AuthDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: AuthRemoteModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthDTOToJson(AuthDTO instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
