import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/domain/usecase/categories_usecase.dart';
import 'package:paisa/feathures/home/presentation/state/categories_state.dart';

final categoriesViewModelProvider =
    StateNotifierProvider<CategoriesViewModel, CategoriesState>(
  (ref) => CategoriesViewModel(
    categoriesUseCase: ref.watch(categoriesUseCaseProvider),
  ),
);

class CategoriesViewModel extends StateNotifier<CategoriesState> {
  final CategoriesUseCase categoriesUseCase;

  CategoriesViewModel({
    required this.categoriesUseCase,
  }) : super(CategoriesState.initialState()) {
    getCategories(false);
  }

  Future<void> getCategories([bool? refresh]) async {
    if (!(refresh ?? false)) {
      state = state.copyWith(isLoading: true);
    } //this is to minimize lag effect in later refreshes,
    //but set it true for initial refresh
    //state = state.copyWith(isLoading: true);

    //state = state.copyWith(isLoading: true);
    var data = await categoriesUseCase.getCategories(refresh ?? false);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        //CustomToast.showToast(failure.error.toString());
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          categories: success,
        );
      },
    );
  }
}
