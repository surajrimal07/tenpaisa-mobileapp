import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/endpoint_constants.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/http/http_service.dart';
import 'package:paisa/feathures/watchlist/data/dto/watchlist_remote_dto.dart';
import 'package:paisa/feathures/watchlist/data/model/watchlist_remote_model.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';

final watchlistRemoteDataSourceProvider =
    Provider<WatchlistRemoteDataSource>((ref) => WatchlistRemoteDataSource(
          dio: ref.read(httpServiceProvider),
          watchlistRemoteModel: ref.read(watchlistRemoteModelProvider),
        ));

class WatchlistRemoteDataSource {
  final Dio dio;
  final WatchlistRemoteModel watchlistRemoteModel;

  WatchlistRemoteDataSource(
      {required this.dio, required this.watchlistRemoteModel});

  Future<Either<Failure, List<WatchlistEntity>>> getWatchlist(
      String email) async {
    try {
      final response =
          await dio.post(EndPoints.getWatchlist, data: {"email": email});
      if (response.statusCode == 200) {
        WatchlistDTO watchlistDTO = WatchlistDTO.fromJson(response.data);

        List<WatchlistEntity> watchlistEntity =
            watchlistRemoteModel.toEntityList(watchlistDTO.data);

        return right(watchlistEntity);
      } else {
        return left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
            showToast: true));
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

  Future<Either<Failure, List<WatchlistEntity>>> createWatchlist(
      String email, String name) async {
    try {
      final response = await dio.post(EndPoints.createWatchlist,
          data: {"email": email, "name": name});
      if (response.statusCode == 200) {
        WatchlistDTO watchlistDTO = WatchlistDTO.fromJson(response.data);

        List<WatchlistEntity> watchlistEntity =
            watchlistRemoteModel.toEntityList(watchlistDTO.data);

        CustomToast.showToast(watchlistDTO.message);

        return right(watchlistEntity);
      } else {
        return left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
            showToast: true));
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

  Future<Either<Failure, List<WatchlistEntity>>> deleteWatchlist(
      String email, String watchlistId) async {
    try {
      final response = await dio.post(EndPoints.deleteWatchlist,
          data: {"email": email, "watchlistId": watchlistId});
      if (response.statusCode == 200) {
        WatchlistDTO watchlistDTO = WatchlistDTO.fromJson(response.data);

        List<WatchlistEntity> watchlistEntity =
            watchlistRemoteModel.toEntityList(watchlistDTO.data);

        CustomToast.showToast(watchlistDTO.message);

        return right(watchlistEntity);
      } else {
        return left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
            showToast: true));
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

  Future<Either<Failure, List<WatchlistEntity>>> renameWatchlist(
      String email, String watchlistId, String name) async {
    try {
      final response = await dio.post(EndPoints.renameWatchlist,
          data: {"email": email, "watchlistId": watchlistId, "newName": name});
      if (response.statusCode == 200) {
        WatchlistDTO watchlistDTO = WatchlistDTO.fromJson(response.data);

        List<WatchlistEntity> watchlistEntity =
            watchlistRemoteModel.toEntityList(watchlistDTO.data);

        CustomToast.showToast(watchlistDTO.message);

        return right(watchlistEntity);
      } else {
        return left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
            showToast: true));
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

  Future<Either<Failure, List<WatchlistEntity>>> addStockToWatchlist(
      String email, String watchlistId, String stock) async {
    try {
      final response = await dio.post(EndPoints.addStockToWatchlist, data: {
        "email": email,
        "watchlistId": watchlistId,
        "stockSymbol": stock
      });
      if (response.statusCode == 200) {
        WatchlistDTO watchlistDTO = WatchlistDTO.fromJson(response.data);

        List<WatchlistEntity> watchlistEntity =
            watchlistRemoteModel.toEntityList(watchlistDTO.data);

        CustomToast.showToast(watchlistDTO.message);

        return right(watchlistEntity);
      } else {
        return left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
            showToast: true));
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

  Future<Either<Failure, List<WatchlistEntity>>> removeStockFromWatchlist(
      String email, String watchlistId, String stock) async {
    try {
      final response = await dio.post(EndPoints.deleteStockFromWatchlist,
          data: {
            "email": email,
            "watchlistId": watchlistId,
            "stockSymbol": stock
          });
      if (response.statusCode == 200) {
        WatchlistDTO watchlistDTO = WatchlistDTO.fromJson(response.data);

        List<WatchlistEntity> watchlistEntity =
            watchlistRemoteModel.toEntityList(watchlistDTO.data);

        CustomToast.showToast(watchlistDTO.message);

        return right(watchlistEntity);
      } else {
        return left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
            showToast: true));
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
