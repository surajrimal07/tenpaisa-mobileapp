import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';

class AuthData {
  final AuthEntity userData;
  final String token;

  AuthData({required this.userData, required this.token});
}
