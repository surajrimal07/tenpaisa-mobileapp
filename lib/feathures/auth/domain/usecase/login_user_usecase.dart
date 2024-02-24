import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/common/cache/auth_cache.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final loginUserUseCaseProvider = Provider<LoginUserUseCase>(
  (ref) => LoginUserUseCase(
      userRepository: ref.watch(authRepositoryProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider),
      authCache: ref.read(authCacheProvider)),
);

class LoginUserUseCase {
  final IAuthRepository userRepository;
  final UserSharedPrefs userSharedPrefs;
  final AuthCache authCache;

  LoginUserUseCase(
      {required this.userRepository,
      required this.userSharedPrefs,
      required this.authCache});

  //i have following issue putting auth caching code here
  // how do i know if data is coming from local or remote?? if local then
  //what's the point of caching it again here?
  //looping the data through cache to again cache
  //make no sense to me

  //for now i will add logic to check internet before saving data to cache

  Future<Either<Failure, AuthEntity>> loginUser(
      String username, String password, bool rememberme) async {
    final result =
        await userRepository.loginUser(username, password, rememberme);
    return result.fold(
      (failure) => Left(failure),
      (authEntity) async {
        await Future.wait([
          userSharedPrefs.setUserToken(authEntity.token),
          userSharedPrefs.setUserEmail(authEntity.email),
          userSharedPrefs.setUserPass(authEntity.password),
          userSharedPrefs.setRememberMe(rememberme),
          userSharedPrefs.setLoggedIn(),
          authCache.saveAuthData(authEntity) //this is wrong
        ]);
        return Right(authEntity);
      },
    );
  }
}
