import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/news/data/repository/news_remote_repository.dart';
import 'package:paisa/feathures/news/domain/entity/news_entity.dart';

final newsRepositoryProvider =
    Provider<INewsRepository>((ref) => ref.read(newsRemoteRepositoryProvider));

abstract class INewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getNews(int page);
}
