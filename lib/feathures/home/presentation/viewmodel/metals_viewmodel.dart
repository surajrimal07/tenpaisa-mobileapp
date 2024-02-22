import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/feathures/home/domain/usecase/metals_usecase.dart';
import 'package:paisa/feathures/home/presentation/state/metals_state.dart';

final metalsViewModelProvider =
    StateNotifierProvider<MetalsViewModel, MetalState>(
  (ref) => MetalsViewModel(
    metalsUseCase: ref.watch(getMetalsUseCaseProvider),
  ),
);

class MetalsViewModel extends StateNotifier<MetalState> {
  final MetalsUseCase metalsUseCase;

  MetalsViewModel({
    required this.metalsUseCase,
  }) : super(MetalState.initialState()) {
    getMetals();
  }

  Future<void> getMetals() async {
    state = state.copyWith(isLoading: true);
    var data = await metalsUseCase.getMetals();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString());
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null, metals: success);
      },
    );
  }
}
