// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'categories_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesDataDTO _$CategoriesDataDTOFromJson(Map<String, dynamic> json) =>
    CategoriesDataDTO(
      data: TopCategoriesRemoteModel.fromJson(
          json['data'] as Map<String, dynamic>),
      isFallback: json['isFallback'] as bool,
      isCached: json['isCached'] as bool,
      dataversion: DataVersionModel.fromJson(
          json['dataversion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesDataDTOToJson(CategoriesDataDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
      'isFallback': instance.isFallback,
      'isCached': instance.isCached,
      'dataversion': instance.dataversion,
    };
