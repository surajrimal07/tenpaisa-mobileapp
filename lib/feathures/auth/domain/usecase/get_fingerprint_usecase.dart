import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final fingerprintUserUseCaseProvider = Provider<FingerprintUserUseCase>((ref) =>
    FingerprintUserUseCase(
        userRepository: ref.watch(authRepositoryProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class FingerprintUserUseCase {
  final IAuthRepository userRepository;
  final UserSharedPrefs userSharedPrefs;

  FingerprintUserUseCase(
      {required this.userRepository, required this.userSharedPrefs});

  Future<bool> getFingerprint() async {
    final result = await userSharedPrefs.getUseFingerprint();
    return result;
  }
}
