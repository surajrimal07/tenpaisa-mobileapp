// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'portfolio_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioRemoteDTO _$PortfolioRemoteDTOFromJson(Map<String, dynamic> json) =>
    PortfolioRemoteDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      portfolioModel: (json['portfolioModel'] as List<dynamic>)
          .map((e) => PortfolioModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PortfolioRemoteDTOToJson(PortfolioRemoteDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'portfolioModel': instance.portfolioModel,
    };
