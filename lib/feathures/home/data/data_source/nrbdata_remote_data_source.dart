import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/home/data/dto/nrbremote_dto.dart';
import 'package:paisa/feathures/home/data/model/nrb_data_remote_model.dart';
import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';

final nrbDataRemoteDataSourceProvider = Provider<NrbRemoteDataSource>((ref) =>
    NrbRemoteDataSource(
        ref.read(httpServiceProvider), ref.read(nrbRemoteDataModelProvider)));

class NrbRemoteDataSource {
  final Dio dio;
  final NrbRemoteDataModel otherRemoteModel;

  NrbRemoteDataSource(this.dio, this.otherRemoteModel);

  Future<Either<Failure, NrbDataEntity>> getNrbData(bool refresh) async {
    try {
      var response = await dio
          .get(EndPoints.nrbData, queryParameters: {'refresh': refresh});

      if (response.statusCode == 200) {
        NrbRemoteDTO nrbDataDTO = NrbRemoteDTO.fromJson(response.data);

        NrbDataEntity nrbEntity = nrbDataDTO.data.toEntity();

        return right(nrbEntity);
      } else {
        return Left(
          Failure(
            error: "Something went wrong fetching Nrb data",
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
