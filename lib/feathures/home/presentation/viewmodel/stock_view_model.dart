import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/feathures/home/domain/usecase/stock_usecase.dart';
import 'package:paisa/feathures/home/presentation/state/stocks_state.dart';

final stockViewModelProvider =
    StateNotifierProvider<StockViewModel, StocksState>(
  (ref) => StockViewModel(
    getStockUseCase: ref.watch(getStockUseCaseProvider),
  ),
);

class StockViewModel extends StateNotifier<StocksState> {
  final GetStockUseCase getStockUseCase;

  StockViewModel({
    required this.getStockUseCase,
  }) : super(StocksState.initialState()) {
    getStocks(false);
  }

  Future<void> getStocks([bool? refresh]) async {
    if (!(refresh ?? false)) {
      state = state.copyWith(isLoading: true);
    }
    //state = state.copyWith(isLoading: true);
    var data = await getStockUseCase.getAllStocks(refresh ?? false);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString());
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null, stocks: success);
      },
    );
  }
}
