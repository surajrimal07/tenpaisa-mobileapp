import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/data/data_source/auth_remote_data_source.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepositoryImpl(
      authRemoteDataSource: ref.watch(authRemoteDataSourceProvider));
});

class AuthRemoteRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, bool>> registerUser(
      AuthEntity user, bool remember) async {
    return await authRemoteDataSource.createUser(user, remember);
  }

  @override
  Future<Either<Failure, AuthEntity>> loginUser(
      String username, String password, bool remember) async {
    final user =
        await authRemoteDataSource.loginUser(username, password, remember);

    return user;
  }

  @override
  Future<Either<Failure, bool>> deleteUser(
      String email, String password) async {
    return await authRemoteDataSource.deleteUser(email, password);
  }

  @override
  Future<Either<Failure, AuthEntity>> getUser(String email) async {
    return await authRemoteDataSource.getUser(email);
  }

  @override
  Future<Either<Failure, AuthEntity>> updateUser(
      String email, String field, String value) {
    return authRemoteDataSource.updateUser(email, field, value);
  }

  @override
  Future<Either<Failure, bool>> verifyOTP(int otp, bool redirect) {
    return authRemoteDataSource.verifyOTP(otp, redirect);
  }

  @override
  Future<Either<Failure, bool>> resendOtp() {
    return authRemoteDataSource.sendOTP();
  }

  @override
  Future<Either<Failure, AuthEntity>> saveStyle(
      String email, String field, String value) {
    return authRemoteDataSource.updateUser(email, field, value);
  }

  @override
  Future<Either<Failure, bool>> forgetPassword(String email) {
    return authRemoteDataSource.forget(email);
  }

  @override
  Future<Either<Failure, AuthEntity>> updateProfilePicture(
      File image, String email) {
    return authRemoteDataSource.updateProfilePicture(image, email);
  }

  @override
  Future<Either<Failure, String>> googleLogin() {
    return authRemoteDataSource.googleLogin();
  }

  @override
  Future<Either<Failure, void>> googleLogout() {
    return authRemoteDataSource.googleDisconnect();
  }
}
