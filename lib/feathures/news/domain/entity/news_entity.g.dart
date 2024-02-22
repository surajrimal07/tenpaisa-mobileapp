// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsEntity _$NewsEntityFromJson(Map<String, dynamic> json) => NewsEntity(
      title: json['title'] as String,
      description: json['description'] as String,
      imgUrl: json['imgUrl'] as String?,
      link: json['link'] as String,
    );

Map<String, dynamic> _$NewsEntityToJson(NewsEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
    };
