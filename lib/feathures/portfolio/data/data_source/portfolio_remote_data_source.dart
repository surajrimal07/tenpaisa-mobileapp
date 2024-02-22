import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_data.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_remote_model.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_data_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';

final portfolioRemoteDataSourceProvider = Provider<PortfolioRemoteDataSource>(
  (ref) => PortfolioRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      porfolioRemoteModel: ref.read(portfolioModelProvider),
      portfolioData: ref.read(portfolioDataProvider)),
);

const showtoast = true;

class PortfolioRemoteDataSource {
  final Dio dio;
  final PortfolioModel porfolioRemoteModel;
  final PortfolioData portfolioData;

  PortfolioRemoteDataSource({
    required this.dio,
    required this.porfolioRemoteModel,
    required this.portfolioData,
  });

  Future<Either<Failure, PortfolioCombined>> createPort(
      String email, String portfolioname, String goal) async {
    try {
      var response = await dio.post(EndPoints.createPortfolio,
          data: {"email": email, "name": portfolioname, "goal": goal});
      if (response.statusCode == 200) {
        GetPortfolioDTO portfolioRemoteDTO =
            GetPortfolioDTO.fromJson(response.data);

        List<PortfolioEntity> portfolioEntityList =
            porfolioRemoteModel.toEntityList(portfolioRemoteDTO.portfolio);

        PortfolioDataEntity portfolioDatas =
            portfolioData.toEntity(portfolioRemoteDTO.portfolioData);

        CustomToast.showToast(portfolioRemoteDTO.message);

        return right(PortfolioCombined(
            portfolioEntityList: portfolioEntityList,
            portfolioDataEntity: portfolioDatas));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
            error: e.error.toString(),
            statusCode: e.response?.statusCode.toString() ?? '0',
            showToast: showtoast),
      );
    }
  }

  Future<Either<Failure, PortfolioCombined>> deletePort(
      String email, String portfolioId) async {
    try {
      var response = await dio.delete(EndPoints.deletePortfolio,
          data: {"email": email, "id": portfolioId});
      if (response.statusCode == 200) {
        GetPortfolioDTO portfolioRemoteDTO =
            GetPortfolioDTO.fromJson(response.data);

        List<PortfolioEntity> portfolioEntityList =
            porfolioRemoteModel.toEntityList(portfolioRemoteDTO.portfolio);

        PortfolioDataEntity portfolioDatas =
            portfolioData.toEntity(portfolioRemoteDTO.portfolioData);

        CustomToast.showToast(portfolioRemoteDTO.message);

        return right(PortfolioCombined(
            portfolioEntityList: portfolioEntityList,
            portfolioDataEntity: portfolioDatas));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
            error: e.error.toString(),
            statusCode: e.response?.statusCode.toString() ?? '0',
            showToast: showtoast),
      );
    }
  }

  Future<Either<Failure, PortfolioCombined>> getPortfolio(String email) async {
    try {
      var response = await dio.post(
        EndPoints.getPortfolio,
        data: {
          "email": email,
        },
      );

      if (response.statusCode == 200) {
        GetPortfolioDTO portfolioRemoteDTO =
            GetPortfolioDTO.fromJson(response.data);

        List<PortfolioEntity> portfolioEntityList =
            porfolioRemoteModel.toEntityList(portfolioRemoteDTO.portfolio);

        PortfolioDataEntity portfolioDatas =
            portfolioData.toEntity(portfolioRemoteDTO.portfolioData);

        return right(PortfolioCombined(
            portfolioEntityList: portfolioEntityList,
            portfolioDataEntity: portfolioDatas));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
            showToast: showtoast,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
            error: e.error.toString(),
            statusCode: e.response?.statusCode.toString() ?? '0',
            showToast: showtoast),
      );
    }
  }

  Future<Either<Failure, PortfolioCombined>> addtoPort(String email,
      String portfolioId, String symbol, int quantity, double price) async {
    try {
      var requestBody = {
        'email': email,
        'id': portfolioId,
        'symboll': symbol,
        'quantityy': quantity,
        'price': price
      };

      var response = await dio.post(
        EndPoints.addStockToPortfolio,
        data: requestBody,
      );

      if (response.statusCode == 200) {
        GetPortfolioDTO portfolioRemoteDTO =
            GetPortfolioDTO.fromJson(response.data);

        List<PortfolioEntity> portfolioEntityList =
            porfolioRemoteModel.toEntityList(portfolioRemoteDTO.portfolio);

        PortfolioDataEntity portfolioDatas =
            portfolioData.toEntity(portfolioRemoteDTO.portfolioData);

        CustomToast.showToast(portfolioRemoteDTO.message);

        return right(PortfolioCombined(
            portfolioEntityList: portfolioEntityList,
            portfolioDataEntity: portfolioDatas));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
            error: e.error.toString(),
            statusCode: e.response?.statusCode.toString() ?? '0',
            showToast: showtoast),
      );
    }
  }

  Future<Either<Failure, PortfolioCombined>> deletestockfromport(
      String email, String id, String symbol, int quantity) async {
    try {
      var requestBody = {
        'email': email,
        'id': id,
        'symbol': symbol,
        'quantity': quantity
      };

      var response = await dio.post(
        EndPoints.deleteStockFromPortfolio,
        data: requestBody,
      );

      if (response.statusCode == 200) {
        GetPortfolioDTO portfolioRemoteDTO =
            GetPortfolioDTO.fromJson(response.data);

        List<PortfolioEntity> portfolioEntityList =
            porfolioRemoteModel.toEntityList(portfolioRemoteDTO.portfolio);

        PortfolioDataEntity portfolioDatas =
            portfolioData.toEntity(portfolioRemoteDTO.portfolioData);

        CustomToast.showToast(portfolioRemoteDTO.message);

        return right(PortfolioCombined(
            portfolioEntityList: portfolioEntityList,
            portfolioDataEntity: portfolioDatas));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
            error: e.error.toString(),
            statusCode: e.response?.statusCode.toString() ?? '0',
            showToast: showtoast),
      );
    }
  }

  Future<Either<Failure, PortfolioCombined>> renameport(
      String email, String id, String newname) async {
    try {
      var requestBody = {'email': email, 'id': id, 'newName': newname};

      var response = await dio.post(
        EndPoints.renamePortfolio,
        data: requestBody,
      );

      if (response.statusCode == 200) {
        GetPortfolioDTO portfolioRemoteDTO =
            GetPortfolioDTO.fromJson(response.data);

        List<PortfolioEntity> portfolioEntityList =
            porfolioRemoteModel.toEntityList(portfolioRemoteDTO.portfolio);

        PortfolioDataEntity portfolioDatas =
            portfolioData.toEntity(portfolioRemoteDTO.portfolioData);

        CustomToast.showToast(portfolioRemoteDTO.message);

        return right(PortfolioCombined(
            portfolioEntityList: portfolioEntityList,
            portfolioDataEntity: portfolioDatas));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
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
