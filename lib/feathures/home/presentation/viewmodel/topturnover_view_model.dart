// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/core/common/toast/app_toast.dart';
// import 'package:paisa/feathures/home/domain/entity/topturnover_entity.dart';
// import 'package:paisa/feathures/home/domain/usecase/categories_usecase.dart';
// import 'package:paisa/feathures/home/presentation/state/topturnover_state.dart';

// final topTurnoverViewModelProvider =
//     StateNotifierProvider<TopTurnoverViewModel, TopTurnoverState>(
//   (ref) => TopTurnoverViewModel(
//     categoriesUseCase: ref.watch(categoriesUseCaseProvider),
//   ),
// );

// class TopTurnoverViewModel extends StateNotifier<TopTurnoverState> {
//   final CategoriesUseCase categoriesUseCase;

//   TopTurnoverViewModel({
//     required this.categoriesUseCase,
//   }) : super(TopTurnoverState.initialState()) {
//     getTopTurnover(false);
//   }

//   Future<void> getTopTurnover([bool? refresh]) async {
//     state = state.copyWith(isLoading: true);
//     var data = await categoriesUseCase.getCategories(refresh ?? false);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         CustomToast.showToast(failure.error.toString());
//       },
//       (success) {
//         List<TopTurnoverEntity> topTurnover = success.topTurnover;
//         state = state.copyWith(
//             isLoading: false, error: null, topturnover: topTurnover);
//       },
//     );
//   }
// }
