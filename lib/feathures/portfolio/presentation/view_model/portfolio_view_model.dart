import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/addstock_portfolio.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/create_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/delete_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/deletestockfrom_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/get_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/rename_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/presentation/state/portfolio_state.dart';

final portfolioViewModelProvider =
    StateNotifierProvider<PortfolioViewModel, PortfolioState>(
  (ref) => PortfolioViewModel(
      getPortfolioUsecase: ref.watch(getPortfolioUseCaseProvider),
      createPortfolioUseCase: ref.watch(addPortfolioUseCaseProvider),
      deletePortfolioUseCase: ref.watch(deletePortfolioUseCaseProvider),
      renamePortfolioUseCase: ref.watch(renamePortfolioUseCaseProvider),
      removeStockToPortfolioUseCase:
          ref.watch(removeStockPortfolioUseCaseProvider),
      addStockToPortfolioUseCase:
          ref.watch(addStockToPortfolioUseCaseProvider)),
);

class PortfolioViewModel extends StateNotifier<PortfolioState> {
  final GetPortfolioUseCase getPortfolioUsecase;
  final AddPortfolioUseCase createPortfolioUseCase;
  final DeletePortfolioUseCase deletePortfolioUseCase;
  final RenamePortfolioUseCase renamePortfolioUseCase;
  final AddStockToPortfolioUseCase addStockToPortfolioUseCase;
  final RemoveStockToPortfolioUseCase removeStockToPortfolioUseCase;

  PortfolioViewModel(
      {required this.getPortfolioUsecase,
      required this.createPortfolioUseCase,
      required this.deletePortfolioUseCase,
      required this.renamePortfolioUseCase,
      required this.addStockToPortfolioUseCase,
      required this.removeStockToPortfolioUseCase})
      : super(PortfolioState.initialState()) {
    getPortfolio();
  }

  Future<void> getPortfolio() async {
    state = state.copyWith(isLoading: true);
    var data = await getPortfolioUsecase.getportfolio();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            portfoliosEntity: success.portfolioEntityList,
            portfolioDataEntity: success.portfolioDataEntity);
      },
    );
  }

  Future<void> createPortfolio(String name, String goal) async {
    //bool successs = false;
    state = state.copyWith(isLoading: true); //weired issue
    // i am having difficulty setting error to null,
    //for temporary solution i have set this code to return bool instead of void
    var data = await createPortfolioUseCase.createPortfolio(name, goal);

    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, showMessage: true, error: failure.error);
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            showMessage: true,
            portfoliosEntity: success.portfolioEntityList,
            portfolioDataEntity: success.portfolioDataEntity);

        // successs = true;
      },
    );
    //return successs;
  }

  Future<void> renamePortfolio(String id, String newName) async {
    state = state.copyWith(isLoading: true);
    var data = await renamePortfolioUseCase.renamePortfolio(id, newName);
    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, showMessage: true, error: failure.error);
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            showMessage: true,
            portfoliosEntity: success.portfolioEntityList,
            portfolioDataEntity: success.portfolioDataEntity);
      },
    );
  }

  Future<void> deletePortfolio(String portfolioId) async {
    state = state.copyWith(isLoading: true);
    var data = await deletePortfolioUseCase.deletePortfolio(portfolioId);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
      },
      (success) {
        CustomToast.showToast("Portfolio Deleted");
        state = state.copyWith(
            isLoading: false,
            error: null,
            showMessage: true,
            portfoliosEntity: success.portfolioEntityList,
            portfolioDataEntity: success.portfolioDataEntity);
      },
    );
  }

  Future<void> addStockToPortfolio(
      String portfolioId, String symbol, int quantity, double price) async {
    state = state.copyWith(isLoading: true);
    var data = await addStockToPortfolioUseCase.addStockPortfolio(
        portfolioId, symbol, quantity, price);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            showMessage: true,
            portfoliosEntity: success.portfolioEntityList,
            portfolioDataEntity: success.portfolioDataEntity);
      },
    );
  }

  Future<void> removeStockToPortfolio(
      String portfolioId, String symbol, int quantity) async {
    state = state.copyWith(isLoading: true);
    var data = await removeStockToPortfolioUseCase.removeStockPortfolio(
        portfolioId, symbol, quantity);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString(), customType: Type.error);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            showMessage: true,
            portfoliosEntity: success.portfolioEntityList,
            portfolioDataEntity: success.portfolioDataEntity);
      },
    );
  }
}
