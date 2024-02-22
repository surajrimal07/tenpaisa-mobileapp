class HomeState {
  final bool isLoading;
  final String? error;
  final bool showMessage;

  HomeState({
    required this.isLoading,
    this.error,
    required this.showMessage,
  });

  factory HomeState.initialState() => HomeState(
        isLoading: false,
        error: null,
        showMessage: false,
      );

  HomeState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
  }) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage);
  }
}
