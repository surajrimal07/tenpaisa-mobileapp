import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final updateUserUseCaseProvider = Provider<UpdateUserUseCase>((ref) =>
    UpdateUserUseCase(userRepository: ref.watch(authRepositoryProvider)));

class UpdateUserUseCase {
  final IAuthRepository userRepository;
  UpdateUserUseCase({required this.userRepository});

  Future<Either<Failure, AuthEntity>> updateUser(
      String email, String field, String value) async {
    return await userRepository.updateUser(email, field, value);
  }
}
