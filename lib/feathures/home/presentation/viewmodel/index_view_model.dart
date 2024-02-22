import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/toast/app_toast.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';
import 'package:paisa/feathures/home/domain/usecase/index_use_case.dart';
import 'package:paisa/feathures/home/presentation/state/index_state.dart';

final indexViewModelProvider =
    StateNotifierProvider<IndexViewModel, IndexState>(
  (ref) => IndexViewModel(
    indexUseCase: ref.watch(indexUseCaseProvider),
  ),
);

class IndexViewModel extends StateNotifier<IndexState> {
  final IndexUseCase indexUseCase;

  IndexViewModel({
    required this.indexUseCase,
  }) : super(IndexState.initialState()) {
    getIndex(false);
  }

  Future<void> getIndex([bool? refresh]) async {
    state = state.copyWith(isLoading: true);
    var data = await indexUseCase.getIndex(refresh ?? false);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        CustomToast.showToast(failure.error.toString());
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null, index: success);
      },
    );
  }
}

// final indexLiveViewModelProvider = ChangeNotifierProvider<IndexViewModelLive>((ref) {
//   final indexViewModel = IndexViewModelLive();
//   final WebSocketServices webSocketServices = ref.read(webSocketServiceProvider);

//   webSocketServices.startWebSocket((data, type) {
//     if (type == 'index') {
//       indexViewModel.onDataCallback(data);
//     }
//   });

//   return indexViewModel;
// });

final indexLiveViewModelProvider = ChangeNotifierProvider<IndexViewModelLive>(
  (ref) => IndexViewModelLive(),
);

class IndexViewModelLive extends ChangeNotifier {
  List<IndexEntity> indexData = [];

  Stream<IndexEntity> get indexDataStream => _indexDataController.stream;
  final _indexDataController = StreamController<IndexEntity>.broadcast();

  void onDataCallback(dynamic data) {
    Map<String, dynamic> newData = json.decode(data);

    data = newData['data'];

    IndexEntity indexEntity = IndexEntity(
      date: data['date'],
      index: data['index'],
      percentageChange: data['percentageChange'],
      turnover: data['turnover'],
      marketStatus: data['marketStatus'],
    );

    indexData.add(indexEntity);
    _indexDataController.add(indexEntity);
  }

  @override
  void dispose() {
    _indexDataController.close();
    super.dispose();
  }
}
