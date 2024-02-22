import 'package:paisa/feathures/news/domain/entity/news_entity.dart';

class NewsState {
  final bool hasReachedMax;
  final int page;
  final List<NewsEntity> news;
  final bool isLoading;

  NewsState({
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
    required this.news,
  });

  factory NewsState.initialState() => NewsState(
        isLoading: false,
        page: 0,
        hasReachedMax: false,
        news: [],
      );

  NewsState copyWith({
    bool? isLoading,
    bool? hasReachedMax,
    int? page,
    List<NewsEntity>? news,
  }) {
    return NewsState(
        isLoading: isLoading ?? this.isLoading,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page,
        news: news ?? this.news);
  }
}
