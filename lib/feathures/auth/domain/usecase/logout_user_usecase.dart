import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final logoutUserUseCaseProvider = Provider<LogoutUserUseCase>(
  (ref) => LogoutUserUseCase(
    userRepository: ref.watch(authRepositoryProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class LogoutUserUseCase {
  final IAuthRepository userRepository;
  final UserSharedPrefs userSharedPrefs;

  LogoutUserUseCase(
      {required this.userRepository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> logoutUser() async {
    try {
      await userSharedPrefs.deleteUserToken();
      await userSharedPrefs.deleteUserEmail();
      await userSharedPrefs.deleteUserPass();
      await userSharedPrefs.deleteRememberMe();
      await userSharedPrefs.remLoggedIn();
      await userSharedPrefs.remUseFingerprint();

      return right(true);
    } catch (e) {
      return left(Failure(error: "Error Occured Logging Out"));
    }
  }
}
