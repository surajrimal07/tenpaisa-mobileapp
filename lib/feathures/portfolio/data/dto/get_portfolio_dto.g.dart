// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'get_portfolio_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPortfolioDTO _$GetPortfolioDTOFromJson(Map<String, dynamic> json) =>
    GetPortfolioDTO(
      portfolio: (json['portfolio'] as List<dynamic>)
          .map((e) => PortfolioModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      portfolioData:
          PortfolioData.fromJson(json['portfolioData'] as Map<String, dynamic>),
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$GetPortfolioDTOToJson(GetPortfolioDTO instance) =>
    <String, dynamic>{
      'portfolio': instance.portfolio,
      'portfolioData': instance.portfolioData,
      'success': instance.success,
      'message': instance.message,
    };
