import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/news/domain/usecase/news_usecase.dart';
import 'package:paisa/feathures/news/presentation/state/news_state.dart';

final newsViewModelProvider =
    StateNotifierProvider<NewsViewModel, NewsState>((ref) {
  return NewsViewModel(
    newsUseCase: ref.watch(newsUseCaseProvider),
  );
});

class NewsViewModel extends StateNotifier<NewsState> {
  final NewsUseCase newsUseCase;

  NewsViewModel({
    required this.newsUseCase,
  }) : super(NewsState.initialState()) {
    getNews();
  }

  Future<void> resetState() async {
    state = NewsState.initialState();
    getNews();
  }

  Future getNews() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final news = currentState.news;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      var data = await newsUseCase.getNews(page);
      data.fold(
        (failure) {
          state = state.copyWith(hasReachedMax: true, isLoading: false);
        },
        (success) {
          if (success.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              news: [...news, ...success],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
