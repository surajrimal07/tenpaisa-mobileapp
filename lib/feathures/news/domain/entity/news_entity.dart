import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_entity.g.dart';

final newsEntityProvider = StateProvider<NewsEntity>((ref) {
  return const NewsEntity(
    title: 'Null',
    description: 'Null',
    imgUrl: 'Null',
    link: 'Null',
  );
});

@JsonSerializable()
class NewsEntity extends Equatable {
  final String title;
  final String link;
  final String description;
  final String? imgUrl;

  const NewsEntity({
    required this.title,
    required this.description,
    this.imgUrl,
    required this.link,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        imgUrl,
        link,
      ];

  factory NewsEntity.fromJson(Map<String, dynamic> json) =>
      _$NewsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NewsEntityToJson(this);

  NewsEntity toEntity() => NewsEntity(
        title: title,
        description: description,
        imgUrl: imgUrl,
        link: link,
      );
}
