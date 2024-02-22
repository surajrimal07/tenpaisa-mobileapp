import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final deleteUserUseCaseProvider = Provider<DeleteUserUseCase>((ref) =>
    DeleteUserUseCase(
        userRepository: ref.watch(authRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class DeleteUserUseCase {
  final IAuthRepository userRepository;
  final UserSharedPrefs userSharedPrefs;
  DeleteUserUseCase(
      {required this.userRepository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> deleteUser(String password) async {
    var email = await userSharedPrefs.getUserEmail() ?? "";
    final result = await userRepository.deleteUser(email, password);
    return result.fold(
      (failure) => Left(failure),
      (data) async {
        await Future.wait([
          userSharedPrefs.deleteUserToken(),
          userSharedPrefs.deleteUserEmail(),
          userSharedPrefs.deleteUserPass(),
          userSharedPrefs.deleteRememberMe(),
          userSharedPrefs.remLoggedIn(),
        ]);
        return const Right(true);
      },
    );
  }
}
