import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final updatePictureUseCaseProvider = Provider<UpdatePictureUseCase>((ref) =>
    UpdatePictureUseCase(userRepository: ref.watch(authRepositoryProvider)));

class UpdatePictureUseCase {
  final IAuthRepository userRepository;

  UpdatePictureUseCase({required this.userRepository});

  Future<Either<Failure, AuthEntity>> updateProfilePicture(
      File image, String email) async {
    return await userRepository.updateProfilePicture(image, email);
  }
}
