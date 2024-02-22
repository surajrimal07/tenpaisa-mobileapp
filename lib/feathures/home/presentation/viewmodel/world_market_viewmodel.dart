import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/feathures/home/domain/usecase/worldmarket_usecase.dart';
import 'package:paisa/feathures/home/presentation/state/world_market_state.dart';

final worldMarketViewModelProvider =
    StateNotifierProvider<WorldMarketViewModel, WorldMarketState>(
  (ref) => WorldMarketViewModel(
    worldMarketUseCase: ref.watch(worldMarketUseCaseProvider),
  ),
);

class WorldMarketViewModel extends StateNotifier<WorldMarketState> {
  final WorldMarketUseCase worldMarketUseCase;

  WorldMarketViewModel({
    required this.worldMarketUseCase,
  }) : super(WorldMarketState.initialState()) {
    getWorldMarket(false);
  }

  Future<void> getWorldMarket([bool? refresh]) async {
    if (!(refresh ?? false)) {
      state = state.copyWith(isLoading: true);
    }
    //  state = state.copyWith(isLoading: true);
    var data = await worldMarketUseCase.getWorldMarket(refresh ?? false);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(
          failure.error.toString(),
        );
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          worldMarket: success,
        );
      },
    );
  }
}
