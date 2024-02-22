import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/repository/portfolio_repository.dart';

final removeStockPortfolioUseCaseProvider =
    Provider<RemoveStockToPortfolioUseCase>((ref) =>
        RemoveStockToPortfolioUseCase(
            portfoliorepository: ref.read(portfolioRepositoryProvider),
            userSharedPrefs: ref.read(userSharedPrefsProvider)));

class RemoveStockToPortfolioUseCase {
  final IPortfolioRepository portfoliorepository;
  final UserSharedPrefs userSharedPrefs;

  RemoveStockToPortfolioUseCase(
      {required this.portfoliorepository, required this.userSharedPrefs});

  Future<Either<Failure, PortfolioCombined>> removeStockPortfolio(
      String id, String symbol, int quantity) async {
    var email = await userSharedPrefs.getUserEmail() ?? "";
    return await portfoliorepository.deletestockfromport(
        email, id, symbol, quantity);
  }
}
