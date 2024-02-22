import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final AuthEntity authEntity;

  AuthState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.authEntity,
  });

  factory AuthState.initialState() => AuthState(
        isLoading: false,
        error: null,
        showMessage: false,
        authEntity: AuthEntity.dummy,
      );

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    AuthEntity? authEntity,
    String? userAmount
  }) {
    return AuthState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        authEntity: authEntity ?? this.authEntity);
  }

  //new method to update user amount //hacky way //not recommended
  // AuthState updateAuthEntityUserAmount(int newUserAmount) {
  //   final updatedAuthEntity = AuthState.copyWith(userAmount: newUserAmount);
  //   return copyWith(authEntity: updatedAuthEntity);
  // }
}
