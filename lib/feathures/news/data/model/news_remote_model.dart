import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_remote_model.g.dart';

final newsRemoteModelProvider = Provider<NewsRemoteModel>((ref) {
  return NewsRemoteModel(
    title: '',
    link: '',
    description: '',
    imgUrl: '',
  );
});

@JsonSerializable()
class NewsRemoteModel {
  String title;
  String link;
  String description;
  @JsonKey(name: 'img_url')
  String imgUrl;

  NewsRemoteModel({
    required this.title,
    required this.link,
    required this.description,
    required this.imgUrl,
  });

  factory NewsRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$NewsRemoteModelFromJson(json);

  NewsRemoteModel toEntity() => NewsRemoteModel(
        title: title,
        link: link,
        description: description,
        imgUrl: imgUrl,
      );

  NewsRemoteModel toEntityFromRemoteModel(NewsRemoteModel remoteModel) =>
      NewsRemoteModel(
        title: remoteModel.title,
        link: remoteModel.link,
        description: remoteModel.description,
        imgUrl: remoteModel.imgUrl,
      );
}
