import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final getUserUseCaseProvider = Provider<GetUserUseCase>(
  (ref) => GetUserUseCase(
    userRepository: ref.watch(authRepositoryProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class GetUserUseCase {
  final IAuthRepository userRepository;
  final UserSharedPrefs userSharedPrefs;

  GetUserUseCase({required this.userRepository, required this.userSharedPrefs});

  Future<Either<Failure, AuthEntity>> getUser() async {
    final email = await userSharedPrefs.getUserEmail() ?? "";

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
}
