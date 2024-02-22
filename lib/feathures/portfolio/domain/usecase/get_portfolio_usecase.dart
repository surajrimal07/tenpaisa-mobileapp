import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/portfolio_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/repository/portfolio_repository.dart';

final getPortfolioUseCaseProvider = Provider<GetPortfolioUseCase>((ref) =>
    GetPortfolioUseCase(
        repository: ref.read(portfolioRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider),
        portfolioCache: ref.read(portfolioCacheProvider)));

class GetPortfolioUseCase {
  final IPortfolioRepository repository;
  final UserSharedPrefs userSharedPrefs;
  final PortfolioCache portfolioCache;

  GetPortfolioUseCase(
      {required this.repository,
      required this.userSharedPrefs,
      required this.portfolioCache});

  Future<Either<Failure, PortfolioCombined>> getportfolio() async {
    final email = await userSharedPrefs.getUserEmail() ?? "";

    final result = await repository.getPortfolio(email);
    return result.fold(
      (failure) => Left(failure),
      (portfolio) async {
       await portfolioCache.addPortfolioData(portfolio);
        return Right(portfolio);
      },
    );
  }
}
