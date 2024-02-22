import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/feathures/home/domain/usecase/commodity_usecase.dart';
import 'package:paisa/feathures/home/presentation/state/commodity_state.dart';

final commodityViewModelProvider =
    StateNotifierProvider<CommodityViewModel, CommodityState>(
  (ref) => CommodityViewModel(
    commodityUseCase: ref.watch(getCommodityUseCaseProvider),
  ),
);

class CommodityViewModel extends StateNotifier<CommodityState> {
  final CommodityUseCase commodityUseCase;

  CommodityViewModel({
    required this.commodityUseCase,
  }) : super(CommodityState.initialState()) {
    getCommodity();
  }

  Future<void> getCommodity() async {
    state = state.copyWith(isLoading: true);
    var data = await commodityUseCase.getCommodity();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString());
      },
      (success) {
        state =
            state.copyWith(isLoading: false, error: null, commodity: success);
      },
    );
  }
}
