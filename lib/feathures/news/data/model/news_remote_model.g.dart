// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'news_remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsRemoteModel _$NewsRemoteModelFromJson(Map<String, dynamic> json) =>
    NewsRemoteModel(
      title: json['title'] as String,
      link: json['link'] as String,
      description: json['description'] as String,
      imgUrl: json['img_url'] as String,
    );

Map<String, dynamic> _$NewsRemoteModelToJson(NewsRemoteModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'description': instance.description,
      'img_url': instance.imgUrl,
    };
