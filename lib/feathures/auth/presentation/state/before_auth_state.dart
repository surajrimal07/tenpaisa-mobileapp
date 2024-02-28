class LoginState {
  final bool isLoading;
  final String? error;
  final bool showMessage;

  LoginState({
    required this.isLoading,
    this.error,
    required this.showMessage,
  });

  factory LoginState.initialState() => LoginState(
        isLoading: false,
        error: null,
        showMessage: false,
      );

  LoginState resetError() {
    return LoginState(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  LoginState copyWith({bool? isLoading, String? error, bool? showMessage
      }) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage);
  }

  @override
  String toString() => 'LoginState(isLoading: $isLoading, error: $error)';
}
