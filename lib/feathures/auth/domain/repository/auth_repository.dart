import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/auth/data/repository/auth_local_repository_impl.dart';
import 'package:paisa/feathures/auth/data/repository/auth_remote_repository.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final connectivity = ref.watch(connectivityStatusProvider);

  return connectivity == ConnectivityStatus.isConnected
      ? ref.watch(authRemoteRepositoryProvider) //authRemoteRepositoryProvider
      : ref.watch(authLocalRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user, bool remember);
  Future<Either<Failure, AuthEntity>> loginUser(
      String username, String password, bool remember);
  Future<Either<Failure, bool>> verifyOTP(int otp, bool redirect);
  Future<Either<Failure, bool>> resendOtp();
  Future<Either<Failure, AuthEntity>> saveStyle(
      String email, String field, String value);
  Future<Either<Failure, bool>> deleteUser(String email, String password);
  Future<Either<Failure, AuthEntity>> getUser(String email);
  Future<Either<Failure, AuthEntity>> updateUser(
      String email, String field, String value);
  Future<Either<Failure, bool>> forgetPassword(String email);
  Future<Either<Failure, AuthEntity>> updateProfilePicture(
      File image, String email);
}
