import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/news/data/data_source/news_remote_datasource.dart';
import 'package:paisa/feathures/news/domain/entity/news_entity.dart';
import 'package:paisa/feathures/news/domain/repository/news_repository.dart';

final newsRemoteRepositoryProvider = Provider<INewsRepository>(
  (ref) => NewsRemoteRepository(
    newsRemoteDataSource: ref.read(newsRemoteDataSourceProvider),
  ),
);

class NewsRemoteRepository implements INewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;

  NewsRemoteRepository({required this.newsRemoteDataSource});

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews(int page) {
    return newsRemoteDataSource.fetchNews(page);
  }
}
