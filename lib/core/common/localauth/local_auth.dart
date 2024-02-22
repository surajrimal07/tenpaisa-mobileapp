import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final localAuthProvider = Provider((ref) => Authentication());

class Authentication {
  Authentication();

  Future<bool> isBiometricsAvailable() async {
    final localAuth = LocalAuthentication();
    return await localAuth.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    final LocalAuthentication localAuth = LocalAuthentication();
    return await localAuth.authenticate(
      localizedReason: 'Authenticate to login',
      options: const AuthenticationOptions(
        stickyAuth: true,
      ),
    );
  }
}
