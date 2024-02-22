import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/home/data/dto/world_remote_dto.dart';
import 'package:paisa/feathures/home/data/model/world_market_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';

final worldRemoteDataSource = Provider<WorldRemoteDataSource>((ref) =>
    WorldRemoteDataSource(
        dio: ref.read(httpServiceProvider),
        worldMarketRemoteModel: ref.read(worldMarketRemoteModelProvider)));

class WorldRemoteDataSource {
  final Dio dio;
  final WorldMarketRemoteModel worldMarketRemoteModel;

  WorldRemoteDataSource({
    required this.dio,
    required this.worldMarketRemoteModel,
  });
  Future<Either<Failure, WorldMarketEntity>> getWorldData(bool refresh) async {
    try {
      var response = await dio
          .get(EndPoints.worldData, queryParameters: {'refresh': refresh});
      if (response.statusCode == 200) {
        WorldMarketRemoteDto worldMarketRemoteDto =
            WorldMarketRemoteDto.fromJson(response.data);

        WorldMarketEntity worldMarketEntity =
            worldMarketRemoteDto.data.toEntity();
        return right(worldMarketEntity);
      } else {
        return Left(
          Failure(
            error: "Something went wrong fetching world data",
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
