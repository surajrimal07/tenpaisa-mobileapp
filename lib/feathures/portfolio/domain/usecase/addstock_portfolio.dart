import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/repository/portfolio_repository.dart';

final addStockToPortfolioUseCaseProvider = Provider<AddStockToPortfolioUseCase>(
    (ref) => AddStockToPortfolioUseCase(
        portfoliorepository: ref.read(portfolioRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class AddStockToPortfolioUseCase {
  final IPortfolioRepository portfoliorepository;
  final UserSharedPrefs userSharedPrefs;

  AddStockToPortfolioUseCase(
      {required this.portfoliorepository, required this.userSharedPrefs});

  Future<Either<Failure, PortfolioCombined>> addStockPortfolio(
      String id, String symbol, int quantity, double price) async {
    var email = await userSharedPrefs.getUserEmail() ?? "";
    return await portfoliorepository.addtoPort(
        email, id, symbol, quantity, price);
  }
}
