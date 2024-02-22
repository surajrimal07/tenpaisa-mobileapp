import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/home/data/dto/index_remote_dto.dart';
import 'package:paisa/feathures/home/data/model/index_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';

final indexRemoteDataSourceProvider = Provider<IndexRemoteDataSource>((ref) =>
    IndexRemoteDataSource(
        ref.read(httpServiceProvider), ref.read(indexRemoteModelProvider)));

class IndexRemoteDataSource {
  final Dio dio;
  final IndexRemoteModel indexRemoteModel;

  IndexRemoteDataSource(this.dio, this.indexRemoteModel);

  Future<Either<Failure, List<IndexEntity>>> getIndex(bool refresh) async {
    try {
      var response = await dio.get(EndPoints.getIndexHistory,
          queryParameters: {'refresh': refresh});

      if (response.statusCode == 200) {
        IndexDTO indexDTO = IndexDTO.fromJson(response.data);

        List<IndexEntity> indexEntities =
            indexRemoteModel.toEntityList(indexDTO.data);
        return right(indexEntities);
      } else {
        return Left(
          Failure(
              error: response.data["message"],
              statusCode: response.statusCode.toString(),
              showToast: true),
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
