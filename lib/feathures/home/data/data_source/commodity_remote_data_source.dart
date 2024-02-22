import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/home/data/dto/commodity_remote_dto.dart';
import 'package:paisa/feathures/home/data/model/commodity_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';

final commodityRemoteDataProvider = Provider<CommodityRemoteDataSource>(
  (ref) => CommodityRemoteDataSource(
    ref.read(commodityRemoteModelProvider),
    ref.read(httpServiceProvider),
  ),
);

class CommodityRemoteDataSource {
  final Dio dio;
  final CommodityRemoteModel commodityRemoteModel;

  CommodityRemoteDataSource(this.commodityRemoteModel, this.dio);

  Future<Either<Failure, List<CommodityEntity>>> getcommodity() async {
    try {
      var response = await dio.get(EndPoints.getCommodity);

      if (response.statusCode == 200) {
        CommodityDTO commodityDTO = CommodityDTO.fromJson(response.data);
        List<CommodityEntity> commodityEntity =
            commodityRemoteModel.toEntityList(commodityDTO.data);

        return right(commodityEntity);
      } else {
        return Left(
          Failure(
            error: "Something went wrong fetching commodity",
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


// Welcome to Alpha Vantage! Your dedicated access key is: YS0XI8PLY5N5CWGM. Please
// record this API key at a safe place for future data access.
