import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/repository/portfolio_repository.dart';

final renamePortfolioUseCaseProvider = Provider<RenamePortfolioUseCase>((ref) =>
    RenamePortfolioUseCase(
        portfoliorepository: ref.read(portfolioRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class RenamePortfolioUseCase {
  final IPortfolioRepository portfoliorepository;
  final UserSharedPrefs userSharedPrefs;

  RenamePortfolioUseCase(
      {required this.portfoliorepository, required this.userSharedPrefs});

  Future<Either<Failure, PortfolioCombined>> renamePortfolio(
      String id, String newName) async {
    var email = await userSharedPrefs.getUserEmail() ?? "";
    return await portfoliorepository.renameport(email, id, newName);
  }
}
