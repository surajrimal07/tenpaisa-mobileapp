import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/data/repository/portfolio_hive_repository.dart';
import 'package:paisa/feathures/portfolio/data/repository/portfolio_remote_repository.dart';

final portfolioRepositoryProvider = Provider<IPortfolioRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);

  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(portfolioRemoteRepositoryProvider)
      : ref.watch(portfolioLocalRepositoryProvider);
});

abstract class IPortfolioRepository {
  Future<Either<Failure, PortfolioCombined>> createPort(
      String email, String name, String goal);

  Future<Either<Failure, PortfolioCombined>> getPortfolio(String email);
  Future<Either<Failure, PortfolioCombined>> addtoPort(
      String email, String id, String symbol, int quantity, double price);
  Future<Either<Failure, PortfolioCombined>> deletestockfromport(
      String email, String id, String symbol, int quantity);
  Future<Either<Failure, PortfolioCombined>> deletePort(
      String email, String portfolioId);
  Future<Either<Failure, PortfolioCombined>> renameport(
      String email, String id, String newname);
}
