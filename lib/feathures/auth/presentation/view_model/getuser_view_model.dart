import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/usecase/get_user_usecase.dart';
import 'package:paisa/feathures/auth/presentation/state/auth_state.dart';

final getUserViewModelProvider =
    StateNotifierProvider<GetUserViewModel, AuthState>(
  (ref) => GetUserViewModel(
    getUserUseCase: ref.watch(getUserUseCaseProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class GetUserViewModel extends StateNotifier<AuthState> {
  final GetUserUseCase getUserUseCase;
  final UserSharedPrefs userSharedPrefs;

  GetUserViewModel({
    required this.getUserUseCase,
    required this.userSharedPrefs,
  }) : super(AuthState.initialState()) {
    getUser();
  }

  Future<void> getUser() async {
    state = state.copyWith(isLoading: true);
    var data = await getUserUseCase.getUser();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString());
      },
      (success) {
        state =
            state.copyWith(isLoading: false, error: null, authEntity: success);
      },
    );
  }
}
