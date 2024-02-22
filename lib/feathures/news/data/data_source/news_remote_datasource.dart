import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/api_endpoints.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/news/domain/entity/news_entity.dart';
import 'package:paisa/feathures/portfolio/data/data_source/portfolio_remote_data_source.dart';

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>(
  (ref) => NewsRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSource({required this.dio});

  Future<Either<Failure, List<NewsEntity>>> fetchNews(int page) async {
    try {
      var response = await dio.get(EndPoints.getNews, queryParameters: {
        '_page': page,
        'limit': ApiEndpoints.limitPage,
      });
      final List<dynamic> newsDataList = response.data;

      List<NewsEntity> newsEntityList = newsDataList
          .map((newsItemJson) => NewsEntity.fromJson(newsItemJson))
          .toList();

      return right(newsEntityList);
    } on DioException catch (e) {
      return Left(
        Failure(
            error: e.error.toString(),
            statusCode: e.response?.statusCode.toString() ?? '0',
            showToast: showtoast),
      );
    }
  }
}
