import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/auth/data/model/auth_hive_model.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';

final authCacheProvider = Provider<AuthCache>((ref) {
  return AuthCache(
      hiveService: ref.read(hiveServiceProvider),
      authHiveModel: ref.read(authHiveModelProvider));
});

class AuthCache {
  final HiveService hiveService;
  final AuthHiveModel authHiveModel;

  AuthCache({required this.hiveService, required this.authHiveModel});

  Future<void> saveAuthData(AuthEntity user) async {
    await hiveService.addUser(authHiveModel.toHiveModel(user));
  }
}
