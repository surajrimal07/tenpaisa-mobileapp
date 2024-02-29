// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'categories_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopCategoriesRemoteModel _$TopCategoriesRemoteModelFromJson(
        Map<String, dynamic> json) =>
    TopCategoriesRemoteModel(
      topGainers: (json['topGainers'] as List<dynamic>)
          .map((e) => TopGainersRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topLoosers: (json['topLoosers'] as List<dynamic>)
          .map((e) => TopLoosersRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topTurnover: (json['topTurnover'] as List<dynamic>)
          .map(
              (e) => TopTurnoverRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topVolume: (json['topVolume'] as List<dynamic>)
          .map((e) => TopVolumeRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topTrans: (json['topTrans'] as List<dynamic>)
          .map((e) =>
              TopTransactionRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopCategoriesRemoteModelToJson(
        TopCategoriesRemoteModel instance) =>
    <String, dynamic>{
      'topGainers': instance.topGainers,
      'topLoosers': instance.topLoosers,
      'topTurnover': instance.topTurnover,
      'topVolume': instance.topVolume,
      'topTrans': instance.topTrans,
    };
