import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/data/data_source/auth_local_data_source.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  print("Going to local repository");
  return AuthLocalRepositoryImpl(
    authLocalDataSource: ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepositoryImpl implements IAuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  AuthLocalRepositoryImpl({required this.authLocalDataSource});

  @override
  Future<Either<Failure, bool>> registerUser(
      AuthEntity user, bool remember) async {
    return await authLocalDataSource.createUser(user, remember);
  }

  @override
  Future<Either<Failure, AuthEntity>> loginUser(
      String username, String password, bool remember) async {
    return authLocalDataSource.loginUser(username, password, remember);
  }

  @override
  Future<Either<Failure, bool>> deleteUser(
      String email, String password) async {
    return await authLocalDataSource.deleteUser(email, password);
  }

  @override
  Future<Either<Failure, AuthEntity>> getUser(String email) async {
    return await authLocalDataSource.getUser(email);
  }

  @override
  Future<Either<Failure, AuthEntity>> updateUser(
      String email, String field, String value) {
    return authLocalDataSource.updateUser(email, field, value);
  }

  @override
  Future<Either<Failure, bool>> verifyOTP(int otp, redirect) async {
    return await authLocalDataSource.verifyOTP();
  }

  @override
  Future<Either<Failure, bool>> resendOtp() async {
    return await authLocalDataSource.resendOTP();
  }

  @override
  Future<Either<Failure, AuthEntity>> saveStyle(
      String email, String field, String value) {
    return authLocalDataSource.saveStyle(email, field, value);
  }

  @override
  Future<Either<Failure, bool>> forgetPassword(String email) {
    return authLocalDataSource.forget();
  }

  @override
  Future<Either<Failure, AuthEntity>> updateProfilePicture(
      File image, String email) {
    return authLocalDataSource.updateProfilePicture();
  }
}
