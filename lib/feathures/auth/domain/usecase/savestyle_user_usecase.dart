import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final saveStyleUserUseCaseProvider = Provider<SaveStyleUserUseCase>((ref) =>
    SaveStyleUserUseCase(
        userRepository: ref.watch(authRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class SaveStyleUserUseCase {
  final IAuthRepository userRepository;
  final UserSharedPrefs userSharedPrefs;

  SaveStyleUserUseCase(
      {required this.userRepository, required this.userSharedPrefs});

  Future<Either<Failure, AuthEntity>> saveStyle(
      String field, String value) async {
    var email = await userSharedPrefs.getUserEmail() ?? "";
    return await userRepository.saveStyle(email, field, value);
  }
}
