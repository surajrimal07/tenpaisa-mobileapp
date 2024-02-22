import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/data/model/portfolio_combined_local_model.dart';

final portfolioLocalDataSource = Provider<PortfolioHiveDataSource>((ref) =>
    PortfolioHiveDataSource(ref.read(hiveServiceProvider),
        ref.read(portfolioLocalCombinedModelProvider)));

class PortfolioHiveDataSource {
  final HiveService _hiveService;
  final PortfolioLocalCombinedModel _portfolioHiveModel;

  PortfolioHiveDataSource(this._hiveService, this._portfolioHiveModel);

  Future<void> addPortfolioData(PortfolioCombined portfolioData) async {
    final portfolioHivedata =
        _portfolioHiveModel.toHiveModel(portfolioData); //addto hive
    await _hiveService.addPortfolioData(portfolioHivedata);
  }

  Future<Either<Failure, PortfolioCombined>> getPortfolio(String email) async {
    try {
      PortfolioLocalCombinedModel portfolio =
          await _hiveService.getPortfolioData();

      final portfoliocombined = portfolio.toEntity();

      return Right(portfoliocombined);
    } on Exception catch (e) {
      return Left(Failure(error: e.toString()));
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, PortfolioCombined>> createPort(
      String email, String name, String goal) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, PortfolioCombined>> deletePort(
      String email, String id) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, PortfolioCombined>> renameport(
      String email, String id, String name) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, PortfolioCombined>> addtoPort(
      String email, String id, String stock, int quantity, double price) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, PortfolioCombined>> deletestockfromport(
      String email, String id, String stock, int quantity) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }
}
