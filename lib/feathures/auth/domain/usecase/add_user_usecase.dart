import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/repository/auth_repository.dart';

final addUserUseCaseProvider = Provider<AddUserUseCase>(
    (ref) => AddUserUseCase(userRepository: ref.watch(authRepositoryProvider)));

class AddUserUseCase {
  final IAuthRepository userRepository;

  AddUserUseCase({required this.userRepository});

  Future<Either<Failure, bool>> addUser(AuthEntity user, bool remember) async {
    return await userRepository.registerUser(user, remember);
  }
}
