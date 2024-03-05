import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final googleLoginUseCaseProvider = Provider<GoogleLoginUseCase>(
  (ref) => GoogleLoginUseCase(
    userRepository: ref.watch(authRepositoryProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class GoogleLoginUseCase {
  final IAuthRepository userRepository;
  final UserSharedPrefs userSharedPrefs;

  GoogleLoginUseCase(
      {required this.userRepository, required this.userSharedPrefs});

  Future<Either<Failure, String>> getUser() async {
    final result = await userRepository.googleLogin();
    return result.fold((failure) => Left(failure), (email) => Right(email));
  }

  Future<Either<Failure, AuthEntity>> getUserData(email) async {
    final result = await userRepository.getUser(email);

    return result.fold(
      (failure) => Left(failure),
      (authEntity) async {
        await Future.wait([
          userSharedPrefs.setUserToken(authEntity.token),
          userSharedPrefs.setUserEmail(authEntity.email),
        ]);
        return Right(authEntity);
      },
    );
  }

  Future<Either<Failure, void>> googleLogout() async {
    final result = await userRepository.googleLogout();
    return result.fold(
        (failure) => Left(failure), (success) => const Right(null));
  }
}
