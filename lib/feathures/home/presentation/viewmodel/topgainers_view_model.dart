// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/core/common/toast/app_toast.dart';
// import 'package:paisa/feathures/home/domain/entity/topgaines_entity.dart';
// import 'package:paisa/feathures/home/domain/usecase/categories_usecase.dart';
// import 'package:paisa/feathures/home/presentation/state/topgainers_state.dart';

// final topGainersViewModelProvider =
//     StateNotifierProvider<TopGainersViewModel, TopGainersState>(
//   (ref) => TopGainersViewModel(
//     categoriesUseCase: ref.watch(categoriesUseCaseProvider),
//   ),
// );

// class TopGainersViewModel extends StateNotifier<TopGainersState> {
//   final CategoriesUseCase categoriesUseCase;

//   TopGainersViewModel({
//     required this.categoriesUseCase,
//   }) : super(TopGainersState.initialState()) {
//     getGainers(false);
//   }

//   Future<void> getGainers([bool? refresh]) async {
//     state = state.copyWith(isLoading: true);
//     var data = await categoriesUseCase.getCategories(refresh ?? false);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         CustomToast.showToast(failure.error.toString());
//       },
//       (success) {
//         List<TopGainersEntity> topGainers = success.topGainers;

//         state = state.copyWith(
//             isLoading: false, error: null, topgainers: topGainers);
//       },
//     );
//   }
// }
