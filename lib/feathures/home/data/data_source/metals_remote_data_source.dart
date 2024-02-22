import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/home/data/dto/metals_remote_dto.dart';
import 'package:paisa/feathures/home/data/model/metals_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';

final metalsRemoteProvider = Provider<MetalsRemoteDataSource>(
  (ref) => MetalsRemoteDataSource(
    ref.read(httpServiceProvider),
    ref.read(metalRemoteModelProvider),
  ),
);

class MetalsRemoteDataSource {
  final Dio dio;
  final MetalRemoteModel metalsRemoteModel;

  MetalsRemoteDataSource(this.dio, this.metalsRemoteModel);

  Future<Either<Failure, List<MetalsEnity>>> getMetal() async {
    try {
      var response = await dio.get(EndPoints.getMetals);

      if (response.statusCode == 200) {
        MetalDTO metalsRemoteDTO = MetalDTO.fromJson(response.data);

        final List<MetalsEnity> metalsEnity =
            metalsRemoteModel.toEntityList(metalsRemoteDTO.metalPrices);
        return right(metalsEnity);
      } else {
        return Left(
          Failure(
            error: "Something went wrong fetching metals",
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
