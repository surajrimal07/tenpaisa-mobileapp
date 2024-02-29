// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'watchlist_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchlistDTO _$WatchlistDTOFromJson(Map<String, dynamic> json) => WatchlistDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => WatchlistRemoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WatchlistDTOToJson(WatchlistDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
