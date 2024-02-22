// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:paisa/core/common/toast/app_toast.dart';
// import 'package:paisa/feathures/home/domain/entity/topvolume_entity.dart';
// import 'package:paisa/feathures/home/domain/usecase/categories_usecase.dart';
// import 'package:paisa/feathures/home/presentation/state/topvolume_state.dart';

// final topVolumeViewModelProvider =
//     StateNotifierProvider<TopVolumeViewModel, TopVolumeState>(
//   (ref) => TopVolumeViewModel(
//     categoriesUseCase: ref.watch(categoriesUseCaseProvider),
//   ),
// );

// class TopVolumeViewModel extends StateNotifier<TopVolumeState> {
//   final CategoriesUseCase categoriesUseCase;

//   TopVolumeViewModel({
//     required this.categoriesUseCase,
//   }) : super(TopVolumeState.initialState()) {
//     getTopVolume(false);
//   }

//   Future<void> getTopVolume([bool? refresh]) async {
//     state = state.copyWith(isLoading: true);
//     var data = await categoriesUseCase.getCategories(refresh ?? false);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         CustomToast.showToast(failure.error.toString());
//       },
//       (success) {
//         List<TopVolumeEntity> topVolume = success.topVolume;
//         state =
//             state.copyWith(isLoading: false, error: null, topvolume: topVolume);
//       },
//     );
//   }
// }
