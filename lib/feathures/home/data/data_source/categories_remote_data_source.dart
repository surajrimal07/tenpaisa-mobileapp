import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/home/data/dto/categories_remote_dto.dart';
import 'package:paisa/feathures/home/data/model/categories_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/topcategories_entity.dart';

final topCategoriesRemoteProvider = Provider<CategoriesRemoteDataSource>((ref) {
  return CategoriesRemoteDataSource(
    ref.read(httpServiceProvider),
    ref.read(userSharedPrefsProvider),
    ref.read(topCategoriesRemoteModelProvider),
  );
});

class CategoriesRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final TopCategoriesRemoteModel topCategoriesRemoteModel;

  CategoriesRemoteDataSource(
      this.dio, this.userSharedPrefs, this.topCategoriesRemoteModel);

  Future<Either<Failure, TopCategoriesEntity>> getAllCategories(
      bool refresh) async {
    try {
      var response = await dio
          .get(EndPoints.getCategories, queryParameters: {'refresh': refresh});

      if (response.statusCode == 200) {
        CategoriesDataDTO categoriesDataDTO =
            CategoriesDataDTO.fromJson(response.data);

        TopCategoriesEntity categoriesEntity =
            categoriesDataDTO.data.toEntity();

        return right(categoriesEntity);
      } else {
        return Left(
          Failure(
            error: "Something went wrong fetching categories",
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
            error: e.error.toString(),
            statusCode: e.response?.statusCode.toString() ?? '0',
            showToast: true),
      );
    }
  }
}
