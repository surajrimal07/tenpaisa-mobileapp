import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/portfolio/data/data_source/portfolio_hive_data_source.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/repository/portfolio_repository.dart';

final portfolioLocalRepositoryProvider = Provider<IPortfolioRepository>((ref) =>
    PortfolioLocalRepository(
        portfolioDataSource: ref.read(portfolioLocalDataSource)));

class PortfolioLocalRepository implements IPortfolioRepository {
  final PortfolioHiveDataSource portfolioDataSource;

  PortfolioLocalRepository({required this.portfolioDataSource});

  @override
  Future<Either<Failure, PortfolioCombined>> addtoPort(String email, String id,
      String symbol, int quantity, double price) async {
    return await portfolioDataSource.addtoPort(
        email, id, symbol, quantity, price);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> createPort(
      String email, String name, String goal) {
    return portfolioDataSource.createPort(email, name, goal);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> deletePort(
      String email, String portfolioId) {
    return portfolioDataSource.deletePort(email, portfolioId);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> deletestockfromport(
      String email, String id, String symbol, int quantity) {
    return portfolioDataSource.deletestockfromport(email, id, symbol, quantity);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> getPortfolio(String email) {
    return portfolioDataSource.getPortfolio(email);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> renameport(
      String email, String id, String newname) {
    return portfolioDataSource.renameport(email, id, newname);
  }
}
