// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/core/network/hive_service.dart';
import 'package:paisa/feathures/auth/data/model/auth_hive_model.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>(
  (ref) => AuthLocalDataSource(
      ref.read(hiveServiceProvider), ref.read(authHiveModelProvider)),
);

class AuthLocalDataSource {
  final HiveService _hiveService;
  final AuthHiveModel _authHiveModel;

  AuthLocalDataSource(this._hiveService, this._authHiveModel);

  Future<Either<Failure, bool>> createUser(
      AuthEntity user, bool remember) async {
    try {
      await _hiveService.addUser(_authHiveModel.toHiveModel(user));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, AuthEntity>> loginUser(
      String username, String password, bool remember) async {
    try {
      AuthHiveModel? user =
          await _hiveService.loginUser(username, password, remember);
      AuthEntity userEntiry = user.toEntity(user);
      if (user == null) {
        return Left(Failure(error: 'Username or password is wrong'));
      } else {
        return Right(userEntiry);
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, AuthEntity>> getUser(String email) async {
    try {
      AuthHiveModel authHiveModel = await _hiveService.getUser(email);
      AuthEntity authEntity = _authHiveModel.toEntity(authHiveModel);
      return Right(authEntity);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteUser(
      String email, String password) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, bool>> resendOTP() async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, bool>> saveUser() async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, bool>> forget() async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, AuthEntity>> updateUser(
      String email, String field, String value) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  //for save style
  Future<Either<Failure, AuthEntity>> saveStyle(
      String email, String field, String value) async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  Future<Either<Failure, bool>> verifyOTP() async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }

  //for update profile picture
  Future<Either<Failure, AuthEntity>> updateProfilePicture() async {
    return Left(Failure(error: "Internet Required", showToast: true));
  }
}
