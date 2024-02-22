// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/core/common/toast/app_toast.dart';
// import 'package:paisa/feathures/home/domain/entity/toptransaction_entity.dart';
// import 'package:paisa/feathures/home/domain/usecase/categories_usecase.dart';
// import 'package:paisa/feathures/home/presentation/state/toptransaction_state.dart';

// final topTransactionViewModelProvider =
//     StateNotifierProvider<TopTransactionViewModel, TopTransactionState>(
//   (ref) => TopTransactionViewModel(
//     categoriesUseCase: ref.watch(categoriesUseCaseProvider),
//   ),
// );

// class TopTransactionViewModel extends StateNotifier<TopTransactionState> {
//   final CategoriesUseCase categoriesUseCase;

//   TopTransactionViewModel({
//     required this.categoriesUseCase,
//   }) : super(TopTransactionState.initialState()) {
//     getTopTransaction(false);
//   }

//   Future<void> getTopTransaction([bool? refresh]) async {
//     state = state.copyWith(isLoading: true);
//     var data = await categoriesUseCase.getCategories(refresh ?? false);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         CustomToast.showToast(failure.error.toString());
//       },
//       (success) {
//         List<TopTransactionEntity> topTransaction = success.topTrans;
//         state = state.copyWith(
//             isLoading: false, error: null, toptransaction: topTransaction);
//       },
//     );
//   }
// }
