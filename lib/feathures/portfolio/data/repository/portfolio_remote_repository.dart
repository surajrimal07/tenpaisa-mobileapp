import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/portfolio/data/data_source/portfolio_remote_data_source.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/repository/portfolio_repository.dart';

final portfolioRemoteRepositoryProvider = Provider<IPortfolioRepository>(
  (ref) => PortfolioRemoteRepositoryImpl(
    portfolioRemoteDataSource: ref.read(portfolioRemoteDataSourceProvider),
  ),
);

class PortfolioRemoteRepositoryImpl implements IPortfolioRepository {
  final PortfolioRemoteDataSource portfolioRemoteDataSource;

  PortfolioRemoteRepositoryImpl({required this.portfolioRemoteDataSource});

  @override
  Future<Either<Failure, PortfolioCombined>> createPort(
      String email, String name, String goal) {
    return portfolioRemoteDataSource.createPort(email, name, goal);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> getPortfolio(String email) {
    return portfolioRemoteDataSource.getPortfolio(email);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> addtoPort(
      String email, String id, String symbol, int quantity, double price) {
    return portfolioRemoteDataSource.addtoPort(
        email, id, symbol, quantity, price);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> deletestockfromport(
      String email, String id, String symbol, int quantity) {
    return portfolioRemoteDataSource.deletestockfromport(
        email, id, symbol, quantity);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> deletePort(
      String email, String portfolioId) {
    return portfolioRemoteDataSource.deletePort(email, portfolioId);
  }

  @override
  Future<Either<Failure, PortfolioCombined>> renameport(
      String email, String id, String newname) {
    return portfolioRemoteDataSource.renameport(email, id, newname);
  }
}
