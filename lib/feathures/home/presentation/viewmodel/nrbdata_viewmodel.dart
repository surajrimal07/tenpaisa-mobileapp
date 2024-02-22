import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/feathures/home/domain/usecase/nrbdata_usecase.dart';
import 'package:paisa/feathures/home/presentation/state/nrbdata_state.dart';

final nrbDataViewModelProvider =
    StateNotifierProvider<NrbDataViewModel, NrbDataState>(
  (ref) => NrbDataViewModel(
    nrbDataUseCase: ref.watch(nrbDataUseCaseProvider),
  ),
);

class NrbDataViewModel extends StateNotifier<NrbDataState> {
  final NrbDataUseCase nrbDataUseCase;

  NrbDataViewModel({
    required this.nrbDataUseCase,
  }) : super(NrbDataState.initialState()) {
    getNrbData(false);
  }

  Future<void> getNrbData([bool? refresh]) async {
    state = state.copyWith(isLoading: true);
    var data = await nrbDataUseCase.getNrbData(refresh ?? false);
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
          nrbData: success,
        );
      },
    );
  }
}
