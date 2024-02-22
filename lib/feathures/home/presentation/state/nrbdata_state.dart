import 'package:paisa/feathures/home/domain/entity/nrbdata_entity.dart';

class NrbDataState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final NrbDataEntity nrbData;

  NrbDataState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.nrbData,
  });

  factory NrbDataState.initialState() => NrbDataState(
      isLoading: false,
      error: null,
      showMessage: false,
      nrbData: NrbDataEntity.dummy);

  NrbDataState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    NrbDataEntity? nrbData,
  }) {
    return NrbDataState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      nrbData: nrbData ?? this.nrbData,
    );
  }
}
