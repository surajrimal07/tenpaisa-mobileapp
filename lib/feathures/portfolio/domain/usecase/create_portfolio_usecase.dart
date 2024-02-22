import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/repository/portfolio_repository.dart';

final addPortfolioUseCaseProvider = Provider<AddPortfolioUseCase>((ref) =>
    AddPortfolioUseCase(
        portfoliorepository: ref.read(portfolioRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class AddPortfolioUseCase {
  final IPortfolioRepository portfoliorepository;
  final UserSharedPrefs userSharedPrefs;

  AddPortfolioUseCase(
      {required this.portfoliorepository, required this.userSharedPrefs});

  Future<Either<Failure, PortfolioCombined>> createPortfolio(
      String name, String goal) async {
    var email = await userSharedPrefs.getUserEmail() ?? "";
    return await portfoliorepository.createPort(email, name, goal);
  }
}
