import 'package:paisa/feathures/home/domain/entity/index_entity.dart';

class IndexState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<IndexEntity> index;

  IndexState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.index,
  });

  factory IndexState.initialState() => IndexState(
        isLoading: false,
        error: null,
        showMessage: false,
        index: [
          const IndexEntity(
            date: '',
            index: 0.0,
            percentageChange: 0.0,
            pointChange: 0.0,
          ),
        ],
      );

  IndexState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<IndexEntity>? index,
  }) {
    return IndexState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        index: index ?? this.index);
  }
}
