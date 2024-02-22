import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/home/data/dto/stock_remote_dto.dart';
import 'package:paisa/feathures/home/data/model/stock_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';

final stockRemoteDataSourceProvider = Provider<StockRemoteDataSource>(
  (ref) => StockRemoteDataSource(
    ref.read(httpServiceProvider),
    ref.read(stockRemoteModeProvider),
  ),
);

class StockRemoteDataSource {
  final Dio dio;
  final StockRemoteModel stockRemoteModel;

  StockRemoteDataSource(this.dio, this.stockRemoteModel);

  Future<Either<Failure, List<StockEntity>>> getAllAsset(bool refresh) async {
    try {
      var response = await dio
          .get(EndPoints.getAllStock, queryParameters: {'refresh': refresh});

      if (response.statusCode == 200) {
        StockRemoteDTO stockRemoteDTO = StockRemoteDTO.fromJson(response.data);
        List<StockEntity> stockEntity =
            stockRemoteModel.toEntityList(stockRemoteDTO.data);
        return right(stockEntity);
      } else {
        return Left(
          Failure(
            error: "Something went wrong fetching stock",
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
