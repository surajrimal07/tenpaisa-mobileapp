import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/news/domain/entity/news_entity.dart';
import 'package:paisa/feathures/news/domain/repository/news_repository.dart';

final newsUseCaseProvider = Provider<NewsUseCase>((ref) {
  return NewsUseCase(
    newsRepository: ref.watch(newsRepositoryProvider),
  );
});

class NewsUseCase {
  final INewsRepository newsRepository;

  NewsUseCase({required this.newsRepository});

  Future<Either<Failure, List<NewsEntity>>> getNews(int page) async {
    return await newsRepository.getNews(page);
  }
}
