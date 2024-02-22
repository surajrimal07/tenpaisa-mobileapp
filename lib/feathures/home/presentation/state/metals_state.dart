import 'package:paisa/feathures/home/domain/entity/metals_entity.dart';

class MetalState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<MetalsEnity> metals;

  MetalState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.metals,
  });

  factory MetalState.initialState() => MetalState(
        isLoading: false,
        error: null,
        showMessage: false,
        metals: [],
      );

  MetalState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<MetalsEnity>? metals,
  }) {
    return MetalState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        metals: metals ?? this.metals);
  }
}
