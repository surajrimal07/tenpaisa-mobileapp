import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final forgetUserUseCaseProvider = Provider<ForgetUserUseCase>((ref) =>
    ForgetUserUseCase(
        userRepository: ref.watch(authRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class ForgetUserUseCase {
  final IAuthRepository userRepository;
  final UserSharedPrefs userSharedPrefs;

  ForgetUserUseCase(
      {required this.userRepository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> forgetPassword(String email) async {
    await userSharedPrefs.setUserEmail(email);
    return await userRepository.forgetPassword(email);
  }
}
