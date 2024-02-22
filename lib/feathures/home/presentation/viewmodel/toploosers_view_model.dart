// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/core/common/toast/app_toast.dart';
// import 'package:paisa/feathures/home/domain/entity/toploosers_entity.dart';
// import 'package:paisa/feathures/home/domain/usecase/categories_usecase.dart';
// import 'package:paisa/feathures/home/presentation/state/toploosers_state.dart';

// final topLoosersViewModelProvider =
//     StateNotifierProvider<TopLoosersViewModel, TopLoosersState>(
//   (ref) => TopLoosersViewModel(
//     categoriesUseCase: ref.watch(categoriesUseCaseProvider),
//   ),
// );

// class TopLoosersViewModel extends StateNotifier<TopLoosersState> {
//   final CategoriesUseCase categoriesUseCase;

//   TopLoosersViewModel({
//     required this.categoriesUseCase,
//   }) : super(TopLoosersState.initialState()) {
//     getLoosers(false);
//   }

//   Future<void> getLoosers([bool? refresh]) async {
//     state = state.copyWith(isLoading: true);
//     var data = await categoriesUseCase.getCategories(refresh ?? false);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         CustomToast.showToast(failure.error.toString());
//       },
//       (success) {
//         List<TopLoosersEntity> topLoosers = success.topLoosers;
//         state = state.copyWith(
//             isLoading: false, error: null, toploosers: topLoosers);
//       },
//     );
//   }
// }
